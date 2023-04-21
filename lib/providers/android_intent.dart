import 'package:fl_shared_link/fl_shared_link.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AndroidIntentController extends ChangeNotifier {
  AndroidIntentModel? intent;
  String? realPath;

  Future<void> update(AndroidIntentModel? data) async {
    if (data != null) {
      final id = data.id;

      if (id != null) {
        intent = data;
        notifyListeners();
      }
    }
  }

  Future<void> resolvePath() async {
    final id = intent?.id;
    if (id != null) {
      realPath = await FlSharedLink().getRealFilePathWithAndroid(id);
      notifyListeners();
    }
  }
}

final androidIntentControllerProvider = ChangeNotifierProvider<AndroidIntentController>((ref) {
  return AndroidIntentController();
});
