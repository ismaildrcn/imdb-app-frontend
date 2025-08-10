import 'package:flutter/material.dart';
import 'package:imdb_app/data/model/user/user_model.dart';
import 'package:imdb_app/features/profile/utils/auth_response.dart';
import 'package:imdb_app/features/profile/utils/storage.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  UserModel? _user;

  bool get isAuthenticated => _isAuthenticated;
  UserModel? get user => _user;

  Future<void> checkAuthStatus() async {
    _user = await SecureStorage.getUser();
    _isAuthenticated = _user != null;
    notifyListeners();
  }

  Future<void> login(AuthResponse response) async {
    await SecureStorage.saveUser(response);
    _user = response.user;
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await SecureStorage.instance.deleteAll();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
