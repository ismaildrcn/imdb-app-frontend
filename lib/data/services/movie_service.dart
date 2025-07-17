import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/movie_model.dart';

class MovieService {
  final _dio = ApiService.instance;

  Future<List<MovieModel>> fetchMovies() async {
    try {
      final response = await _dio.get(
        '/3/movie/top_rated',
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
