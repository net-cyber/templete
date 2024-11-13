import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:templete/src/core/router/route_name.dart';
import 'package:templete/src/presentation/components/buttons/accent_login_button.dart';
import 'package:templete/src/presentation/components/buttons/forgot_text_button.dart';
import 'package:templete/src/presentation/components/keyboard_dismisser.dart';
import 'package:templete/src/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:templete/src/presentation/pages/auth/login/riverpod/provider/login_provider.dart';
import 'package:templete/src/presentation/theme/app_colors.dart';
import 'package:templete/src/riverpod/provider/app_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.watch(loginProvider.notifier);
    final bool isDarkMode = ref.watch(appProvider).isDarkMode;

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: isDarkMode ? AppColors.dontHaveAnAccBackDark : AppColors.white,
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                    padding: REdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        18.verticalSpace,
                        Text(
                          'Login',
                          style: GoogleFonts.k2d(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                          ),
                        ),
                        26.verticalSpace,
                        OutlinedBorderTextField(
                          label: 'Email',
                          onChanged: loginNotifier.setEmail,
                          inputType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          isError: loginState.isLoginError || loginState.isEmailNotValid,
                          textInputAction: TextInputAction.next,
                          descriptionText: loginState.isEmailNotValid
                              ? 'Email is not valid'
                              : (loginState.isLoginError
                                  ? 'Login credentials are not valid'
                                  : null),
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          obscure: loginState.showPassword,
                          label: 'Password',
                          onChanged: loginNotifier.setPassword,
                          textCapitalization: TextCapitalization.none,
                          isError:
                              loginState.isLoginError || loginState.isPasswordNotValid,
                          descriptionText: loginState.isPasswordNotValid
                              ? 'Password should contain minimum 8 characters'
                              : (loginState.isLoginError
                                  ? 'Login credentials are not valid'
                                  : null),
                          suffixIcon: IconButton(
                            splashRadius: 25,
                            icon: Icon(
                                loginState.showPassword
                                  ? FlutterRemix.eye_line
                                  : FlutterRemix.eye_close_line,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              size: 20.r,
                            ),
                            onPressed: () =>
                                loginNotifier.setShowPassword(!loginState.showPassword),
                          ),
                        ),
                        12.verticalSpace,
                        Align(
                          alignment: Alignment.centerRight,
                          child: ForgotTextButton(
                            title:
                                'Forgot password?',
                            fontColor:
                                isDarkMode ? AppColors.white : AppColors.black,
                            onPressed: () =>
                                  context.pushNamed(RouteName.noConnection),
                          ),
                        ),
                        40.verticalSpace,
                        AccentLoginButton(
                          title: 'Login',
                          isLoading: loginState.isLoading,
                          onPressed: () => loginNotifier.login(context),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
