import 'dart:io';

// import 'package:fast_gbk/fast_gbk.dart';
import 'package:aiya/decryptor.dart';
import 'package:aiya/endpoints.dart';
import 'package:aiya/providers/auth.dart';
import 'package:aiya/providers/hpc.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:aiya/main.dart';
import 'package:xml/xml.dart';

part 'decryption.g.dart';

@riverpod
Future<String> doDecryption(DoDecryptionRef ref, String? realPath) async {
  // const codec = GbkCodec(allowMalformed: true);

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
  int blockSize = 16;
  int blockCurrent = 0;
  int blockTotal = (5216 / blockSize).round();
  final encryptedFileHeader = bytes.getRange(tvSize + 36, tvSize + 36 + 5216);
  List<int> decryptedFileHeader = List.empty(growable: true);

  // 分块运行AES解密
  while (blockTotal > blockCurrent) {
    decryptedFileHeader.addAll(
      decryptor.run(Uint8List.fromList(encryptedFileHeader.skip(blockCurrent * blockSize).take(blockSize).toList())).toList(),
    );
    blockCurrent++;
  }

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
  logger.i('docId: $docId');
  logger.i('docKey: $docKey');

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

  // 解密文件体
  final fileBodyStartAt = tvSize + 36 + 5216;
  final fileBodyEndAt = bytes.length - 1;
  var encryptedFileBody = Uint8List.fromList(bytes.getRange(fileBodyStartAt, fileBodyEndAt).toList());
  List<int> decryptedFileBody = List.empty(growable: true);

  // 创建一个新的解密器，用来解密文件体
  final bodyDecryptor = Decryptor(
    Uint8List.fromList(decryptor.decodeKeyHex(keyHex)),
    Uint8List.fromList([87, 198, 33, 169, 54, 135, 1, 189, 163, 116, 240, 180, 171, 67, 205, 71]),
  );

  // Pad一下文件体，防止不对齐产生乱码
  blockTotal = ((fileBodyEndAt - fileBodyStartAt) / blockSize).ceil();
  blockCurrent = 0;

  logger.i('fileBodyStartAt: $fileBodyStartAt');
  logger.i('fileBodyEndAt: $fileBodyEndAt');
  logger.i('blockTotal: $blockTotal');

  // 分块运行AES解密
  while (blockTotal > blockCurrent) {
    List<int> blockData = List.empty(growable: true);
    blockData.insertAll(0, encryptedFileBody.skip(blockCurrent * blockSize).take(blockSize));

    // 配合上面的ceil来为block填充差(padding)
    if (blockData.length < blockSize) {
      logger.i('padded: ${blockSize - blockData.length}!');
      blockData.insertAll(blockData.length, List.filled(blockSize - blockData.length, blockSize - blockData.length));
    }

    decryptedFileBody.addAll(bodyDecryptor.run(Uint8List.fromList(blockData.toList())).toList());
    blockCurrent++;
  }

  // logger.i(decryptedFileBody);

  // var result1 = String.fromCharCodes(decryptedFileBody.where((n) => n > 7).toList());
  // var result2 = codec.decode(decryptedFileBody.where((n) => n > 7).toList());

  // logger.i('utf8: $result1');
  // logger.i('gbk: $result2');

  // 文件体写入临时目录，完成解密流程
  List<String> extensionList = [];
  String extensionName = "";

  for (var i = realPath.length - 1; i > -1; i--) {
    if (realPath[i] != '.') {
      extensionList.add(realPath[i]);
    } else {
      break;
    }
  }

  extensionName = extensionList.reversed.join();

  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = '$tempPath/${uuid.v1()}.$extensionName';

  logger.i(realPath);
  logger.i(filePath);

  // .where((n) {
  //   // sanitize bytes
  //   if (n == 13 || n == 10 || n == 32 || n > 32) {
  //     return true;
  //   }
  //   return false;
  // })

  // var stream = File(filePath).openWrite(encoding: gbk);
  // stream.write(codec.decode(decryptedFileBody.toList()));

  await File(filePath).writeAsBytes(decryptedFileBody.toList());

  return filePath;
}
