import 'package:imdb_app/data/datasources/local.dart';
import 'package:imdb_app/data/model/movie_model.dart';

class MovieRepository {
  final MovieLocalDataSource localDataSource;

  MovieRepository(this.localDataSource);

  Future<List<MovieModel>> fetchMovies() {
    return localDataSource.getMovies();
  }
}
