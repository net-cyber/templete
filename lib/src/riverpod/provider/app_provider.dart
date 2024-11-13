import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templete/src/riverpod/notifier/app_notifier.dart';
import 'package:templete/src/riverpod/state/app_state.dart';

final appProvider = StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier();
});
