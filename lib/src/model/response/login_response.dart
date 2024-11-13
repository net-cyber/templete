import 'package:templete/src/model/data/login_data.dart';

class LoginResponse {
  LoginData _loginData;
  LoginResponse({
    required LoginData loginData,
  }) : _loginData = loginData;

  LoginData get loginData => _loginData;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : _loginData = LoginData.fromJson(json);
}
