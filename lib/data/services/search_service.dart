import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/movie/movie_model.dart';
import 'package:imdb_app/data/services/movie_service.dart';

class SearchService {
  final _dio = ApiService.instance;

  MovieService get _movieService => MovieService();
  List<MovieModel> saerchMovieWithFullData = [];

  Future<List<MovieModel>> fetchMovies({required String searchText}) async {
    List<MovieModel> temp = [];
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {'query': searchText},
      );
      temp = (response.data["results"] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
      for (var element in temp) {
        final resp = await _movieService.fetchMovie(element.id);
        saerchMovieWithFullData.add(resp);
      }
      return saerchMovieWithFullData;
    } catch (e) {
      rethrow;
    }
  }
}
