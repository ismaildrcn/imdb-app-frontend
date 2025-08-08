import 'package:dio/dio.dart';
import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/user/user_model.dart';

class UserService {
  final _dio = ApiService.instance;

  Future<Response?> createUser(UserModel user) async {
    try {
      final response = await _dio.post('/auth/register', data: user.toJson(), );
      return response;
    } catch (e) {
      print("Error creating user: $e");
      return null;
    }
  }
}
