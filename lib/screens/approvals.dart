import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:aiya/utils.dart';
import 'package:aiya/providers/android_intent.dart';

// const List<String> files = [
//   "https://www.xiangmin.net/downloads/test.pdf",
//   "https://www.xiangmin.net/downloads/test.docx",
//   "https://www.xiangmin.net/downloads/test.doc",
//   "https://www.xiangmin.net/downloads/test.xlsx",
//   "https://www.xiangmin.net/downloads/test.xls",
//   "https://www.xiangmin.net/downloads/test.pptx",
//   "https://www.xiangmin.net/downloads/test.ppt",
//   "https://www.xiangmin.net/downloads/test.txt",
// ];

class Approvals extends HookConsumerWidget {
  const Approvals({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(androidIntentControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('文件列表'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(controller.realPath ?? "无输入"),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        onTap(context, controller.realPath);
      }),
    );
  }

  Future onTap(BuildContext context, String? realPath) async {
    if (realPath == null) {
      return;
    }

    bool isGranted = await PermissionUtil.check();

    if (isGranted && context.mounted) {
      Navigator.pushNamed(context, 'viewer');
    } else {
      debugPrint('no permission');
    }
  }
}
