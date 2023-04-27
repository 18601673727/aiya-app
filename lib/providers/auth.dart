import 'package:aiya/main.dart';
import 'package:shared_preferences_riverpod/shared_preferences_riverpod.dart';

final sessionIdProvider = createPrefProvider<String>(
  prefs: (_) => prefs,
  prefKey: 'sessionId',
  defaultValue: '',
);

final displayNameProvider = createPrefProvider<String>(
  prefs: (_) => prefs,
  prefKey: 'displayName',
  defaultValue: '',
);
