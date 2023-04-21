import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:aiya/providers/android_intent.dart';

// Incoming wechat file url example:
// content://com.tencent.mm.external.fileprovider/attachment/aiyaencrypted.txt

class Viewer extends HookConsumerWidget {
  const Viewer({super.key});
  static const route = 'viewer';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(androidIntentControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('文件预览'),
      ),
      body: controller.realPath != null
          ? PowerFileViewWidget(
              filePath: controller.realPath!,
              // loadingBuilder: (viewType, progress) {
              //   return Container(
              //     color: Colors.grey,
              //     alignment: Alignment.center,
              //     child: Text("加载中: $progress"),
              //   );
              // },
              // errorBuilder: (viewType) {
              //   return Container(
              //     color: Colors.red,
              //     alignment: Alignment.center,
              //     child: const Text("出错了"),
              //   );
              // },
            )
          : null,
    );
  }
}
