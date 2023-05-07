import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<bool> check() async {
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.storage.status;
      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        return false;
      } else {
        PermissionStatus requestStatus = await Permission.storage.request();
        if (requestStatus.isGranted) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return true;
    }
  }
}

List<int> decodeKeyHex(String input) {
  List<int> badResult = [];
  int length = input.length;

  if (length % 2 != 0) return badResult;

  List<int> b = List.filled(length ~/ 2, 0);
  int b1, b2;

  for (int i = 0; i < length; i += 2) {
    b1 = int.parse(input[i], radix: 16);
    b2 = int.parse(input[i + 1], radix: 16);

    if (b1 < 0 || b2 < 0) return badResult;

    b[i ~/ 2] = (b1 << 4 | b2);
  }

  return b;
}
