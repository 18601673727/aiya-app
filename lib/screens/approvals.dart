import 'package:aiya/main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:aiya/utils.dart';
import 'package:aiya/providers/android_intent.dart';
import 'package:aiya/widgets/blurry_dialog.dart';

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

  Future<void> executeAfterBuild(callback) async {
    await Future.delayed(const Duration(microseconds: 1000));
    callback();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(androidIntentControllerProvider);

    executeAfterBuild(() {
      logger.i(controller.realPath);
      ref.read(androidIntentControllerProvider.notifier).realPath = controller.realPath;
    });

    if (controller.realPath != null) {
      Future.delayed(Duration.zero, () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            continueCallBack() async {
              bool isGranted = await PermissionUtil.check();

              if (isGranted && context.mounted) {
                Navigator.pushNamed(context, 'viewer');
              } else {
                logger.i('用户拒绝了Android权限的请求');
                ref.read(androidIntentControllerProvider).intent = null;
                ref.read(androidIntentControllerProvider).realPath = null;
              }
            }

            cancelCallback() async {
              ref.read(androidIntentControllerProvider).intent = null;
              ref.read(androidIntentControllerProvider).realPath = null;
              Navigator.of(context).pop();
            }

            BlurryDialog alert = BlurryDialog(
              '尝试解密并打开',
              '取消',
              '提示',
              '接收到来自外部应用打开文件的请求',
              continueCallBack,
              cancelCallback,
            );

            return alert;
          },
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('待办事项'),
      ),
    );
  }
}
