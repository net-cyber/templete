import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templete/src/core/utils/local_storage.dart';
import 'package:templete/src/riverpod/state/app_state.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier() : super(const AppState());
  Future<void> fetchTheme() async {
    final bool isDarkMode = LocalStorage.instance.getIsDarkMode();
    state = state.copyWith(isDarkMode: isDarkMode);
  }
  Future<void> changeTheme(bool isDarkMode) async {
    await LocalStorage.instance.setIsDarkMode(isDarkMode);
    state = state.copyWith(isDarkMode: isDarkMode);
  }
}
