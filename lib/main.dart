import 'package:fl_shared_link/fl_shared_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:aiya/providers/android_intent.dart';
import 'package:aiya/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PowerFileViewManager.initLogEnable(true, true);
  PowerFileViewManager.initEngine();

  prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer();

  // 冷启动时把intent写入
  final intent = await FlSharedLink().intentWithAndroid;
  await container.read(androidIntentControllerProvider).update(intent);
  await container.read(androidIntentControllerProvider).resolvePath();

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  static const primaryColor = Color(0xFF44D62C);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 注册intent相关的热处理事件
    FlSharedLink().receiveHandler(onIntent: (AndroidIntentModel? intent) async {
      logger.i("接收到来自其他应用的intent!");
      await ref.read(androidIntentControllerProvider).update(intent);
      await ref.read(androidIntentControllerProvider).resolvePath();
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: appRoutes,
      onGenerateRoute: (settings) => appGeneratedRoutes(settings),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[700],
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        textSelectionTheme: const TextSelectionThemeData(cursorColor: primaryColor),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.black87,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
