
import 'package:templete/src/core/handlers/api_result.dart';
import 'package:templete/src/model/response/login_response.dart';
import 'package:templete/src/model/response/user_response.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  });
  Future<ApiResult<UserResponse>> fetchUserData();
}
