class UserModel {
  String name;
  String email;
  String? token;

  UserModel({
    required this.name,
    required this.email,
    this.token,
  });

  factory UserModel.fromJson(Map data) {
    return UserModel(
      email: data['email'],
      name: data['name'],
      token: data['token'],
    );
  }

  void setToken(String token) {
    this.token = token;
  }
}
