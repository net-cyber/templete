class UserData {
  final int _id;
  final String _name;
  final String _email;
  final String _password;
  final String _role;
  final String _avatar;

  UserData({
    required String id,
    required String name,
    required String email,
    required String password,
    required String role,
    required String avatar,
  })  : _id = int.parse(id),
        _name = name,
        _email = email,
        _password = password,
        _role = role,
        _avatar = avatar;

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get role => _role;
  String get avatar => _avatar;

  UserData.fromJson(Map<String, dynamic> json)
      : _id = int.parse(json['_id']),
        _name = json['name'],
        _email = json['email'],
        _password = json['password'],
        _role = json['role'],
        _avatar = json['avatar'];
}
