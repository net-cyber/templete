import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:templete/src/presentation/theme/app_colors.dart';
import '../../../riverpod/provider/app_provider.dart';

class ForgotTextButton extends ConsumerWidget {
  final String title;
  final Function() onPressed;
  final double? fontSize;
  final Color? fontColor;
  final double? letterSpacing;

  const ForgotTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.fontSize,
    this.fontColor = AppColors.black,
    this.letterSpacing = -14 * 0.02,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appProvider);
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
          (states) => state.isDarkMode
              ? AppColors.mainBackDark
              : AppColors.dontHaveAccBtnBack,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.k2d(
          fontWeight: FontWeight.w500,
          fontSize: fontSize ?? 13.sp,
          color: fontColor,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
