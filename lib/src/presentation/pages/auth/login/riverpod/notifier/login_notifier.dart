import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:templete/src/core/router/route_name.dart';
import 'package:templete/src/core/utils/app_connectivity.dart';
import 'package:templete/src/core/utils/app_helpers.dart';
import 'package:templete/src/core/utils/app_validators.dart';
import 'package:templete/src/core/utils/local_storage.dart';
import 'package:templete/src/presentation/pages/auth/login/riverpod/state/login_state.dart';
import 'package:templete/src/repository/auth_repository.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;
  LoginNotifier(this._authRepository) : super(const LoginState());

  void setPassword(String password){
    state = state.copyWith(password: password.trim(), isLoginError: false, isPasswordNotValid: false, isEmailNotValid: false,);
  }

  void setEmail(String email){
    state = state.copyWith(email: email.trim(), isLoginError: false, isPasswordNotValid: false, isEmailNotValid: false,);
  }
  void setShowPassword(bool showPassword){
    state = state.copyWith(showPassword: showPassword);
  }

  Future<void> login(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if(connected){
      if(!AppValidators.isValidEmail(state.email)){
        state = state.copyWith(isEmailNotValid: true);
        return;
      }
      if(!AppValidators.isValidPassword(state.password)){
        state = state.copyWith(isPasswordNotValid: true);
        return;
      }
      state = state.copyWith(isLoading: true);
      final result = await _authRepository.login(email: state.email, password: state.password);

      result.when(
        success: (data) async {
      await LocalStorage.instance.setAccessToken(data.loginData.accessToken);
      await LocalStorage.instance.setRefreshToken(data.loginData.refreshToken);

      await fetchUserData(context);
      print('login success');
      state = state.copyWith(isLoading: false);
      final router = GoRouter.of(context);
      if(mounted){
        router.goNamed(RouteName.main);
      }
      
    }, failure: (error) {

        state = state.copyWith(isLoading: false, isLoginError: true);

      },);
    } else {

      if(mounted){
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
    
  }
  Future<void> fetchUserData(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if(connected){
      final result = await _authRepository.fetchUserData();
      result.when(success: (data){
        state = state.copyWith(isLoading: false);
      },
      failure: (error){
        state = state.copyWith(isLoading: false);
      });
    } else {
      if(mounted){
        AppHelpers.showCheckFlash(
          context,
          'Please check your internet connection',
        );
      }
      state = state.copyWith(isLoading: false);
    }
  }
}
