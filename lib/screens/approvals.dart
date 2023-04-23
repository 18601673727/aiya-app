import 'package:aiya/main.dart';
import 'package:aiya/repositories/approvals.dart';
import 'package:aiya/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:aiya/utils.dart';
import 'package:aiya/providers/android_intent.dart';
import 'package:aiya/widgets/blurry_dialog.dart';

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
    final approvalsAsync = ref.watch(fetchApprovalsProvider(pageNumber: 1));

    executeAfterBuild(() {
      // logger.i(controller.realPath);
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
                ref.read(androidIntentControllerProvider).reset();
                // logger.i('android intent reseted');
              }
            }

            cancelCallback() async {
              ref.read(androidIntentControllerProvider).reset();
              // logger.i('android intent reseted');
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
      appBar: AppBar(
        title: const Text('待办事项'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: const Text('未登录'),
              ),
            ),
          ),
        ],
      ),
      body: approvalsAsync.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => const Text('Oops'),
        data: (data) => Stack(
          children: [
            ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: index == data.length - 1 ? 0 : 20,
                    bottom: index == data.length - 1 ? 30 : 20,
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[800],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addVerticalSpace(15),
                          Text(data[index].fileName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          addVerticalSpace(30),
                          Text('来自企业用户 ${data[index].userName} 的${data[index].actionType}申请', style: const TextStyle(fontSize: 10)),
                          data[index].description.isNotEmpty
                              ? Text(data[index].description, style: const TextStyle(fontSize: 10))
                              : addVerticalSpace(0),
                          Text('申请于 ${data[index].createdAt}', style: const TextStyle(fontSize: 10)),
                          addVerticalSpace(30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              minimumSize: const Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text('拒绝', style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {},
                          ),
                          addVerticalSpace(5),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              minimumSize: const Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text('允许', style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
