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

  Map toJson() {
    return {
      "email": email,
      "name": name,
      "token": token,
    };
  }

  void setToken(String token) {
    this.token = token;
  }
}
