import 'package:imdb_app/data/datasources/remote.dart';
import 'package:imdb_app/data/model/person_model.dart';

class PersonService {
  final _dio = ApiService.instance;

  Future<PersonModel> fetchPerson({required int personId}) async {
    try {
      final response = await _dio.get('/3/person/$personId');
      return PersonModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
