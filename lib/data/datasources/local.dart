import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:imdb_app/data/model/movie_model.dart';

class MovieLocalDataSource {
  Future<List<MovieModel>> getMovies() async {
    final data = await rootBundle.loadString(
      'assets/json/most_popular_movies.json',
    );
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((e) => MovieModel.fromJson(e)).toList();
  }
}
