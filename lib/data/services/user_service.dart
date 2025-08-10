import 'package:dio/dio.dart';
import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/user/user_model.dart';

class UserService {
  final _dio = ApiService.instance;

  Future<Response?> createUser(UserModel user) async {
    try {
      final response = await _dio.post('/auth/register', data: user.toJson());
      return response;
    } catch (e) {
      print("Error creating user: $e");
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
      print("Error signing in user: $e");
      return null;
    }
  }

  Future<UserModel?> getUserByToken(String token) async {
    try {
      final response = await _dio.get(
        '/auth/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      print("Error fetching user by token: $e");
    }
    return null;
  }
}
