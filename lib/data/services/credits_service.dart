import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/credits_model.dart';

class CreditsService {
  final _dio = ApiService.instance;

  Future<Credits> fetchCredits(movieId) async {
    // try {
    // cast ve crew olmak üzere tüm datalar mevcut
    final response = await _dio.get('/remote/3/movie/$movieId/credits');
    return Credits.fromJson(response.data);
    // } catch (e) {
    //   rethrow;
    // }
  }
}
