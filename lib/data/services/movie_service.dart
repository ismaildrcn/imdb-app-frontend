import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/movie/movie_model.dart';

class MovieTypes {
  static const String topRated = "top_rated";
  static const String popular = "popular";
  static const String nowPlaying = "now_playing";
  static const String upcoming = "upcoming";
}

class MovieService {
  final _dio = ApiService.instance;

  Future<List<MovieModel>> fetchMovies({required String type}) async {
    try {
      final url = '/remote/movie/$type';
      final response = await _dio.get(url);
      return (response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> fetchMoviesWithoutToken({
    required String type,
  }) async {
    try {
      final url = '/remote/movie/$type/without-token';
      final response = await _dio.get(url);
      return (response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieModel> fetchMovie(
    int movieId, {
    int? userId,
    String language = 'en-US',
  }) async {
    try {
      final response = await _dio.get(
        '/remote/movie/$movieId',
        queryParameters: {if (userId != null) 'user_id': userId},
      );
      return MovieModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
