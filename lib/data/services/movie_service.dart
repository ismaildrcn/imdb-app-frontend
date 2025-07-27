import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/movie_model.dart';

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
      final response = await _dio.get(
        '/3/movie/$type',
        queryParameters: {'language': 'en-US', 'page': 1},
      );
      return (response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieModel> fetchMovie(
    int movieId, {
    String language = 'en-US',
  }) async {
    // try {
    final response = await _dio.get(
      '/3/movie/$movieId',
      queryParameters: {'language': language},
    );
    return MovieModel.fromJson(response.data);
    // } catch (e) {
    //   rethrow;
    // }
  }
}
