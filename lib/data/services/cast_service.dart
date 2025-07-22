import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/cast_model.dart';

class CastService {
  final _dio = ApiService.instance;

  Future<List<CastModel>> fetchCast(movieId) async {
    // try {
    // cast ve crew olmak üzere tüm datalar mevcut
    final response = await _dio.get('/3/movie/$movieId/credits');
    return (response.data['cast'] as List)
        .map((e) => CastModel.fromJson(e))
        .toList();
    // } catch (e) {
    //   rethrow;
    // }
  }
}
