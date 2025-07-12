import 'package:imdb_app/data/datasources/local.dart';
import 'package:imdb_app/data/model/movie_model.dart';

class MostPopularMoviesRepository {
  final MostPopularMoviesLocalDataSource localDataSource;

  MostPopularMoviesRepository(this.localDataSource);

  Future<List<MovieModel>> fetchMovies() {
    return localDataSource.getMovies();
  }
}

class MovieRepository {
  final MovieLocalDataSource localDataSource;

  MovieRepository(this.localDataSource);

  Future<MovieModel> fetchMovie() {
    return localDataSource.getMovie();
  }
}
