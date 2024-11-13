import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:templete/src/core/utils/local_storage.dart';
import 'package:templete/src/core/router/route_name.dart';
import 'package:templete/src/core/utils/app_connectivity.dart';
import 'package:templete/src/presentation/pages/initial/splash/riverpod/state/splash_state.dart';

class SplashNotifier extends StateNotifier<SplashState> {
  SplashNotifier() : super(const SplashState());

  Future<void> checkAuth(
    BuildContext context, {
    required VoidCallback goMain,
    required VoidCallback goLogin,
    required VoidCallback onboarding,
  }) async {
    state = state.copyWith(isLoading: true);
    final connection = await AppConnectivity.connectivity();
    if (connection) {
      final storage = LocalStorage.instance;
      final isDoneOnboarding = storage.getIsDoneOnboarding();
      
      if (isDoneOnboarding) {
        // if onboarding is true,check token
        final accessToken = storage.getAccessToken();
        if (accessToken != null) {
          goMain.call();
        } else {
          goLogin.call();
        }
      } else {
        // if onboarding is false,go onboarding
        onboarding.call();
      }
    } else {
      if(!mounted) return;
      // if no internet,go no connection
      context.replace(RouteName.noConnection);
    }
  }
}
