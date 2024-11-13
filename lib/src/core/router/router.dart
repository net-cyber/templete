import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:templete/src/core/router/route_name.dart';
import 'package:templete/src/presentation/pages/auth/login/login_page.dart';
import 'package:templete/src/presentation/pages/auth/register/register_page.dart';
import 'package:templete/src/presentation/pages/initial/no_connection/no_connection_page.dart';
import 'package:templete/src/presentation/pages/initial/onboarding/onboarding_page.dart';
import 'package:templete/src/presentation/pages/initial/splash/splash_page.dart';
import 'package:templete/src/presentation/pages/main/main_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash
    GoRoute(
      name: RouteName.splash,
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    // Onboarding
    GoRoute(
      name: RouteName.onboarding,
      path: '/${RouteName.onboarding}',
      builder: (context, state) => const OnboardingPage(),
    ),
    // Register
    GoRoute(
      name: RouteName.register,
      path: '/${RouteName.register}',
      builder: (context, state) => const RegisterPage(),
    ),
    // login
    GoRoute(
      name: RouteName.login,
      path: '/${RouteName.login}',
      builder: (context, state) => const LoginPage(),
    ),
    // No connection
    GoRoute(
      name: RouteName.noConnection,
      path: '/${RouteName.noConnection}',
      builder: (context, state) => const NoConnectionPage(),
    ),
    // Main with custom transition
    GoRoute(
      name: RouteName.main,
      path: '/${RouteName.main}',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const MainPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);