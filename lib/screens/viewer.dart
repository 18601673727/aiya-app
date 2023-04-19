import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Incoming wechat file url example:
// content://com.tencent.mm.external.fileprovider/attachment/aiyaencrypted.txt

class Viewer extends HookConsumerWidget {
  const Viewer({super.key});
  static const route = 'viewer';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: const Center(
        child: Text('Viewer'),
      ),
    );
  }
}
