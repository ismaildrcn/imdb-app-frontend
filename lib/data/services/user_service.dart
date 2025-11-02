import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:imdb_app/data/datasources/remote.dart';

class UserService {
  final _dio = ApiService.instance;

  Future<Response?> getWishlist(int userId) async {
    try {
      final response = await _dio.get('/user/$userId/wishlist');
      return response;
    } catch (e) {
      debugPrint("Error fetching wishlist: $e");
      return null;
    }
  }
}
