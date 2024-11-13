import 'package:templete/src/model/data/user_data.dart';

class UserResponse {
  final UserData user;
  UserResponse({required this.user});
  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        user: UserData.fromJson(json),
      );
}
