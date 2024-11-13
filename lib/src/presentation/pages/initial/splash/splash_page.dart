import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:templete/src/core/utils/local_storage.dart';
import 'package:templete/src/core/router/route_name.dart';
import 'package:templete/src/presentation/components/custom_progress_indicator.dart';
import 'package:templete/src/presentation/pages/initial/splash/riverpod/provider/splash_provider.dart';
import 'package:templete/src/presentation/theme/app_colors.dart';


class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed( Duration.zero, () {
      ref.read(splashProvider.notifier).checkAuth(
        context,
        goMain: () => context.goNamed(RouteName.main),
        goLogin: () => context.goNamed(RouteName.login),
        onboarding: () => context.goNamed(RouteName.onboarding),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.instance.getIsDarkMode();
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      backgroundColor: isDarkMode ? AppColors.mainBackDark : AppColors.mainBack,
      body:  JumpingDots(
       color: isDarkMode ? AppColors.white : AppColors.black,
        radius: 10,
        numberOfDots: 3,
      ),
    );
  }
}
