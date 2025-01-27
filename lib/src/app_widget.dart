import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:templete/src/core/router/router.dart';
import 'package:templete/src/core/router/slide_transition.dart';
import 'package:templete/src/riverpod/provider/app_provider.dart';

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        themeMode: ref.watch(appProvider).isDarkMode ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark().copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomTransitionBuilder(),
                },
              ),
            ),
        theme: ThemeData.light().copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomTransitionBuilder(),
                },
              ),
        ),
      ),
    );
  }
}