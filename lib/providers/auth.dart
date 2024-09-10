import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/network_response.dart';
import '../repositories/auth.dart';
import '../services/persistence.dart';
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
        getUser();
      },
    );
  }

  Future<bool> get isLoggedIn async {
    if (_user != null) {
      return true;
    }
    final String userData = await _persistenceService.read('user');
    if (userData.trim().isEmpty) {
      return false;
    }
    _user = UserModel.fromJson(jsonDecode(userData));
    return true;
  }

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

  Future<NetworkResponseModel> getUser() async {
    try {
      NetworkResponseModel response =
          await _authRepository.getUser(user!.token ?? "");
      if (response.success) {
        final String originalToken = _user!.token ?? "";
        _user = UserModel.fromJson(response.data);
        _user?.setToken(originalToken);
        _persistenceService.write('user', jsonEncode(_user?.toJson()));
      } else {
        _user = null;
      }
      notifyListeners();
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _persistenceService.delete('user');
      _user = null;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
