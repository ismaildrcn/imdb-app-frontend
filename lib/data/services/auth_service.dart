import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/user/user_model.dart';

class AuthService {
  final _dio = ApiService.instance;

  Future<Response?> createUser(UserModel user) async {
    try {
      final response = await _dio.post('/auth/register', data: user.toJson());
      return response;
    } catch (e) {
      debugPrint("Error creating user: $e");
      return null;
    }
  }

  Future<Response?> signInUser(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return response;
    } catch (e) {
      debugPrint("Error signing in user: $e");
      return null;
    }
  }
}
