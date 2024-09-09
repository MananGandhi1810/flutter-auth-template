import 'package:flutter/material.dart';

import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;

  bool get isLoggedIn => user != null;

  void register(String name, String email, String password) {}

  void login(String email, String password) {}

  void getUser() {}
}
