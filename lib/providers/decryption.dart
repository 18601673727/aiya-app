import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart';
import 'package:encryptions/encryptions.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:aiya/main.dart';
import 'package:aiya/utils.dart';
import 'package:aiya/endpoints.dart';
import 'package:aiya/providers/auth.dart';
import 'package:aiya/providers/hpc.dart';

part 'decryption.g.dart';

@riverpod
Future<String> doDecryption(DoDecryptionRef ref, String? realPath) async {
  if (realPath == null) {
    return '';
  }

  final File file = File(realPath);
  RandomAccessFile fileOpen = await file.open(mode: FileMode.read);

  int byte = 0;
  int count = 0;
  List<int> bytes = [];

  // 遍历整个文件（加载到内存中）
  while (byte != -1) {
    byte = fileOpen.readByteSync();
    bytes.add(byte);
    count++;
  }

  logger.i('Read file into memory, total bytes: $count');

  await fileOpen.close();

  // 解密第一步，先找TvSize
  var firstEqualSignOfHtmlTagPosition = -1;
  var firstSpaceOrCloseMarkOfHtmlTagPosition = -1;

  for (var i = 0; i < 200; i++) {
    if (bytes[i] == 61) {
      // starts with "="
      firstEqualSignOfHtmlTagPosition = i;
      continue;
    }

    if (firstEqualSignOfHtmlTagPosition > 0 && bytes[i] == 32) {
      // ends with "space"
      firstSpaceOrCloseMarkOfHtmlTagPosition = i;
      break;
    }

    if (firstEqualSignOfHtmlTagPosition > 0 && bytes[i] == 62) {
      // ends with ">"
      firstSpaceOrCloseMarkOfHtmlTagPosition = i;
      break;
    }
  }

  if (firstEqualSignOfHtmlTagPosition < 0 || firstSpaceOrCloseMarkOfHtmlTagPosition < 0) {
    logger.i('Couldn\'t find TvSize, returning realPath.');
    return realPath;
  }

  final tvSize = int.parse(String.fromCharCodes(bytes.getRange(
    firstEqualSignOfHtmlTagPosition + 1,
    firstSpaceOrCloseMarkOfHtmlTagPosition,
  )));

  logger.i('Found TvSize: $tvSize');

  // 拿到TvSize之后，判断该文件是否是合法的aiya加密文件
  if (tvSize == 0 || tvSize < 0) {
    logger.e('TvSize invalid, returning realPath');
    return realPath;
  }

  var signature = String.fromCharCodes(bytes.getRange(tvSize, tvSize + 24));

  if (signature != 'TrustView UDP Protected.' && signature != 'Encrypted file for aiya.') {
    logger.i('Signature not match, looks like a un-encrypted file, retuning realPath.');
    return realPath;
  }

  logger.i(signature);

  // 解密文件头
  AES headDecryptor = AES.ofCBC(
    base64Decode('jv1AqZ5qqzvPBC/b3JfNInhwYGV+o4xFRe86keTtCj4='),
    base64Decode('Rm9yIEZyb2RvISVAJipNOw=='),
    PaddingScheme.PKCS5Padding,
  );

  final encryptedFileHeader = bytes.skip(tvSize + 36).take(5216).toList();
  Uint8List decryptedFileHeader = await headDecryptor.decrypt(Uint8List.fromList(encryptedFileHeader));

  // 拿到EntireString
  var entireString = String.fromCharCodes(decryptedFileHeader.skip(96).take(5014).where((a) => a > 0));

  // 拿到DocKey
  if (entireString.isEmpty) {
    logger.e('Cannot get EntireString, abort!');
    return '';
  }

  final RegExp docIdRegex = RegExp(r'DocID=(\d+)');
  final RegExp docKeyRegex = RegExp(r'DocKey=([a-f\d]+)');
  final Match? docIdMatch = docIdRegex.firstMatch(entireString);
  final Match? docKeyMatch = docKeyRegex.firstMatch(entireString);
  final String docId = docIdMatch?.group(1) ?? '';
  final String docKey = docKeyMatch?.group(1) ?? '';
  logger.i('docId: $docId\ndocKey: $docKey');

  // 提交DocId, DocKey, SessonId拿到KeyHex
  String keyHex = '';
  final hpc = ref.watch(hpcProvider);
  final payload = decryptPayload(ref.watch(sessionIdProvider), docId, docKey);
  final url = Uri.https('drm.aiyainfo.com:9443', '/tvud/rd');
  final body = {'xmlDoc': payload};
  final response = await hpc.post(url, body: body);

  // 检查结果
  final document = XmlDocument.parse(response.body);

  for (var element in document.findAllElements('PropertyObject')) {
    if (element.attributes[0].value == 'java.lang.String') {
      if (element.attributes[1].value == 'keyHex') {
        keyHex = element.attributes[2].value;
      }
    }
  }

  if (keyHex.isEmpty) {
    logger.e('keyHex is empty, abort decryption!');
    return '';
  } else {
    logger.i('Got keyHex: $keyHex');
  }

  final bodyKey = decodeKeyHex(keyHex);
  logger.i('bodyDecryptor Key: $bodyKey');

  // 解密文件体
  final fileBodyStartAt = tvSize + 36 + 5216;
  final fileBodyEndAt = bytes.length - 1;
  const batchSize = 1024; // 此处不是block而是batch，为了与AES自身的分块机制相区分
  final batchTotal = ((fileBodyEndAt - fileBodyStartAt) / batchSize).ceil();
  int batchCurrent = 0;
  Uint8List encryptedFileBody = Uint8List.fromList(bytes.getRange(fileBodyStartAt, fileBodyEndAt).toList());
  List<int> decryptedFileBody = List.empty(growable: true);

  // 创建一个新的解密器，用来解密文件体
  AES bodyDecryptor = AES.ofCBC(
    Uint8List.fromList(bodyKey),
    base64Decode('V8YhqTaHAb2jdPC0q0PNRw=='),
    PaddingScheme.PKCS5Padding,
  );

  logger.i('File Body Starts At: $fileBodyStartAt\nFile Body Ends At: $fileBodyEndAt\nTotal Batches To Decrypt: $batchTotal');

  // 分批运行AES解密
  while (batchTotal > batchCurrent) {
    List<int> temp = List.empty(growable: true);
    temp.insertAll(0, encryptedFileBody.skip(batchCurrent * batchSize).take(batchSize));
    decryptedFileBody.addAll(await bodyDecryptor.decrypt(Uint8List.fromList(temp)));
    batchCurrent++;
  }

  // 文件体写入临时目录，完成解密流程
  Directory tempDir = await getTemporaryDirectory();
  List<String> extensionList = [];
  String extensionName = "";

  for (int i = realPath.length - 1; i > -1; i--) {
    if (realPath[i] == '.') break;
    extensionList.add(realPath[i]);
  }

  extensionName = extensionList.reversed.join();
  final filePath = '${tempDir.path}/${uuid.v1()}.$extensionName';
  await File(filePath).writeAsBytes(decryptedFileBody.toList());
  logger.i('Input: $realPath\nOutput: $filePath');

  return filePath;
}
