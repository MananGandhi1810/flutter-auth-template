import 'package:auth_template/models/network_response.dart';
import 'package:auth_template/repositories/auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  final AuthRepository _authRepository = AuthRepository();

  bool get isLoggedIn => user != null;

  Future<NetworkResponseModel> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      NetworkResponseModel response =
          await _authRepository.register(name, email, password);
      if (response.success) {
        response.data = UserModel.fromJson(response.data);
        return response;
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<NetworkResponseModel> login(String email, String password) async {
    try {
      NetworkResponseModel response =
          await _authRepository.login(email, password);
      if (response.success) {
        user = UserModel.fromJson(response.data['user']);
        user?.setToken(response.data['token']);
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void getUser() {}
}
