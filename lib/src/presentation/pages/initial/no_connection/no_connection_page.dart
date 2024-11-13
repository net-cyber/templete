import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:templete/src/core/utils/local_storage.dart';
import 'package:templete/src/core/router/route_name.dart';
import 'package:templete/src/presentation/theme/app_colors.dart';

class NoConnectionPage extends ConsumerWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const SizedBox(height: 200, width: double.infinity),
          const Icon(
            FlutterRemix.wifi_off_fill,
            size: 120,
            color: AppColors.black,
          ),
          const SizedBox(height: 20),
          Text(
            'No internet connection',
            style: GoogleFonts.k2d(
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              context.goNamed(RouteName.splash);
            
            },
            child: const Icon(
              FlutterRemix.restart_fill,
              color: AppColors.black,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
