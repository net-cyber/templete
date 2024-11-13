import 'package:templete/src/core/di/injection.dart';
import 'package:templete/src/core/handlers/api_result.dart';
import 'package:templete/src/core/handlers/http_service.dart';
import 'package:templete/src/core/handlers/network_exceptions.dart';
import 'package:templete/src/model/response/login_response.dart';
import 'package:templete/src/model/response/user_response.dart';
import 'package:templete/src/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    final data = {
      "email": email,
      "password": password,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post('/api/v1/auth/login', data: data);
      return ApiResult.success(data: LoginResponse.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
  @override
  Future<ApiResult<UserResponse>> fetchUserData() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('/api/v1/auth/profile');
      return ApiResult.success(data: UserResponse.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
