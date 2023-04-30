import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';

class Decryptor {
  late CBCBlockCipher cipher;

  Decryptor(Uint8List key, Uint8List iv) {
    assert(256 == key.length * 8);
    assert(128 == iv.length * 8);

    // Create a CBC block cipher with AES, and initialize with key and IV
    cipher = CBCBlockCipher(AESEngine())..init(false, ParametersWithIV(KeyParameter(key), iv));
  }

  Uint8List run(Uint8List cipherText) {
    assert(128 == cipherText.length * 8);

    // Decrypt the cipherText block-by-block
    final paddedPlainText = Uint8List(cipherText.length); // allocate space

    var offset = 0;

    while (offset < cipherText.length) {
      offset += cipher.processBlock(cipherText, offset, paddedPlainText, offset);
    }

    assert(offset == cipherText.length);

    return paddedPlainText;
  }

  List<int> hexToBytes(String s) {
    List<int> badResult = [];

    int length = s.length;
    if (length % 2 != 0) {
      return badResult;
    }

    List<int> b = List.filled(length ~/ 2, 0);
    int b1, b2;

    for (int i = 0; i < length; i += 2) {
      b1 = int.parse(s[i], radix: 16);
      b2 = int.parse(s[i + 1], radix: 16);
      if (b1 < 0 || b2 < 0) {
        return badResult;
      }
      b[i ~/ 2] = (b1 << 4 | b2);
    }

    return b;
  }
}
