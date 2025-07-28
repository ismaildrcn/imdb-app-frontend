import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/movie_model.dart';

class GenreService {
  final _dio = ApiService.instance;

  Future<List<Genres>> fetchGenres() async {
    // try {
    final response = await _dio.get('/3/genre/movie/list');
    return (response.data['genres'] as List)
        .map((e) => Genres.fromJson(e))
        .toList();
    // } catch (e) {
    //   rethrow;
    // }
  }
}
