import 'package:fl_shared_link/fl_shared_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:aiya/providers/android_intent.dart';
import 'package:aiya/routes.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PowerFileViewManager.initLogEnable(true, true);
  PowerFileViewManager.initEngine();

  final container = ProviderContainer();

  // 冷启动时把intent写入
  final intent = await FlSharedLink().intentWithAndroid;
  container.read(androidIntentControllerProvider).intent = intent;

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 注册intent相关的热处理事件
    FlSharedLink().receiveHandler(onIntent: (AndroidIntentModel? data) {
      logger.i("接收到来自其他应用的intent!");
      ref.read(androidIntentControllerProvider).update(data);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: appRoutes,
      onGenerateRoute: (settings) => appGeneratedRoutes(settings),
    );
  }
}
