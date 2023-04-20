import 'package:fl_shared_link/fl_shared_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

// final androidIntentProvider = FutureProvider<AndroidIntentModel?>((ref) async {
//   return await FlSharedLink().intentWithAndroid;
// });

// final onAndroidIntentProvider = FutureProvider<String?>((ref) {
//   return;
// });

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  // 冷启动时把intent写入
  final intent = await FlSharedLink().intentWithAndroid;
  container.read(androidIntentControllerProvider).intent = intent;

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class AndroidIntentController extends ChangeNotifier {
  AndroidIntentModel? intent;

  Future<void> update(data) async {
    intent = data;
    notifyListeners();
  }
}

final androidIntentControllerProvider = ChangeNotifierProvider<AndroidIntentController>((ref) {
  return AndroidIntentController();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(androidIntentControllerProvider);

    FlSharedLink().receiveHandler(onIntent: (AndroidIntentModel? data) {
      logger.i("接收到来自其他应用的intent!");
      ref.read(androidIntentControllerProvider).update(data);
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text(controller.intent?.id ?? ""),
        ),
      ),
    );
  }
}
