import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templete/src/core/di/dependency_manager.dart';
import 'package:templete/src/presentation/pages/auth/login/riverpod/notifier/login_notifier.dart';
import 'package:templete/src/presentation/pages/auth/login/riverpod/state/login_state.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(authRepository);
});
