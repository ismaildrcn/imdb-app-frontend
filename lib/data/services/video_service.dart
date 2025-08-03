import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/video_model.dart';

class VideoService {
  final _dio = ApiService.instance;

  Future<Videos> fetchVideos(movieId) async {
    // try {
    // cast ve crew olmak üzere tüm datalar mevcut
    final response = await _dio.get('/remote/3/movie/$movieId/videos');
    return Videos.fromJson(response.data);
    // } catch (e) {
    //   rethrow;
    // }
  }
}
