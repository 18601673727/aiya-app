import 'package:aiya/providers/decryption.dart';
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
    final plainTextAsync = ref.watch(doDecryptionProvider(controller.realPath));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('文件预览')),
      body: plainTextAsync.when(
        loading: () => Container(
          color: Colors.grey[800],
          alignment: Alignment.center,
          child: Text('正在解密..', style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
        error: (error, stack) => const ErrorWidget(),
        data: (decryptedPath) => decryptedPath.isEmpty
            ? const ErrorWidget()
            : PowerFileViewWidget(
                filePath: decryptedPath,
                loadingBuilder: (viewType, progress) {
                  return Container(
                    color: Colors.grey[800],
                    alignment: Alignment.center,
                    child: Text('加载腾讯组件中: $progress，\n如果该步骤卡顿太久，\n请尝试在微信中安装QQ浏览器'),
                  );
                },
                errorBuilder: (viewType) {
                  return Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: const Text('出错了，\n请尝试在微信中安装QQ浏览器后再试'),
                  );
                },
              ),
      ),
    );
  }
}

class ErrorWidget extends ConsumerWidget {
  const ErrorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.grey[800],
      alignment: Alignment.center,
      child: const Text(
        '文件解密失败',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
