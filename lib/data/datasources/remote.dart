import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '${dotenv.env["BASE_URL"]}', // senin API base adresin
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['API_TOKEN']}',
      },
    ),
  );

  static Dio get instance => _dio;
}
