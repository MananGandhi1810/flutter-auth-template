import 'dart:convert';

import 'package:auth_template/models/network_response.dart';
import 'package:auth_template/repositories/auth.dart';
import 'package:auth_template/services/persistence.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  final AuthRepository _authRepository = AuthRepository();
  final PersistenceService _persistenceService = PersistenceService();

  AuthProvider() {
    _persistenceService.read("user").then(
      (value) {
        if (value.isEmpty) {
          return;
        }
        _user = UserModel.fromJson(jsonDecode(value));
        notifyListeners();
      },
    );
  }

  bool get isLoggedIn => _user != null;

  UserModel? get user => _user;

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
      }
      notifyListeners();
      return response;
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
        _user = UserModel.fromJson(response.data['user']);
        _user?.setToken(response.data['token']);
        _persistenceService.write('user', jsonEncode(_user?.toJson()));
      }
      notifyListeners();
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void getUser() {}
}
