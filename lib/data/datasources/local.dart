import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:imdb_app/data/model/most_popular_movies_model.dart';

class MostPopularMoviesLocalDataSource {
  Future<List<MostPopularMoviesModel>> getMovies() async {
    final data = await rootBundle.loadString(
      'assets/json/most_popular_movies.json',
    );
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((e) => MostPopularMoviesModel.fromJson(e)).toList();
  }
}
