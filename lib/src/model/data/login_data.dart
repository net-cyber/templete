class LoginData {
  String _accessToken;
  String _refreshToken;
  LoginData({
    required String accessToken,
    required String refreshToken,
  })  : _accessToken = accessToken,
        _refreshToken = refreshToken;

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  LoginData.fromJson(Map<String, dynamic> json)
      : _accessToken = json['access_token'],
        _refreshToken = json['refresh_token'];
}

