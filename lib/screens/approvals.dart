import 'dart:convert';

import 'package:aiya/permission_util.dart';
// import 'package:aiya/screens/viewer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

const files = [
  "https://www.xiangmin.net/downloads/test.pdf",
];

class Approvals extends HookConsumerWidget {
  const Approvals({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('文件列表'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'viewer');
        },
      ),
    );
  }
}

Future onTap(BuildContext context, String downloadUrl, String downloadPath) async {
  bool isGranted = await PermissionUtil.check();
  if (isGranted) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (ctx) {
    //     return PowerFileViewPage(
    //       downloadUrl: downloadUrl,
    //       downloadPath: downloadPath,
    //     );
    //   }),
    // );
  } else {
    debugPrint('no permission');
  }
}

Future getFilePath(String type, String assetPath) async {
  final directory = await getTemporaryDirectory();
  return "${directory.path}/fileview/${base64.encode(utf8.encode(assetPath))}.$type";
}
