import 'dart:typed_data';

import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';
import 'package:fl_shared_link/fl_shared_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:aiya/providers/android_intent.dart';
import 'package:aiya/routes.dart';
import 'package:aiya/decryptor.dart';

late SharedPreferences prefs;

var uuid = const Uuid();

var logger = Logger(
  printer: PrettyPrinter(),
);

var decryptor = Decryptor(
  Uint8List.fromList([
    142,
    253,
    64,
    169,
    158,
    106,
    171,
    59,
    207,
    4,
    47,
    219,
    220,
    151,
    205,
    34,
    120,
    112,
    96,
    101,
    126,
    163,
    140,
    69,
    69,
    239,
    58,
    145,
    228,
    237,
    10,
    62
  ]),
  Uint8List.fromList([70, 111, 114, 32, 70, 114, 111, 100, 111, 33, 37, 64, 38, 42, 77, 59]),
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
