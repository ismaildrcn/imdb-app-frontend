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

  Future<Response?> addToWishlist(int userId, int movieId) async {
    try {
      final response = await _dio.post(
        '/user/$userId/wishlist',
        data: {'movie_id': movieId},
      );
      return response;
    } catch (e) {
      debugPrint("Error adding to wishlist: $e");
      return null;
    }
  }

  Future<Response?> removeFromWishlist(int userId, int movieId) async {
    try {
      final response = await _dio.delete('/user/$userId/wishlist/$movieId');
      return response;
    } catch (e) {
      debugPrint("Error removing from wishlist: $e");
      return null;
    }
  }
}
