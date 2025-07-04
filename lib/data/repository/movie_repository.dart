import 'package:imdb_app/data/datasources/local.dart';
import 'package:imdb_app/data/model/most_popular_movies_model.dart';

class MostPopuplarMoviesRepository {
  final MostPopularMoviesLocalDataSource localDataSource;

  MostPopuplarMoviesRepository(this.localDataSource);

  Future<List<MostPopularMoviesModel>> fetchMovies() {
    return localDataSource.getMovies();
  }
}
