import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          '${dotenv.env["BASE_URL"]}:${dotenv.env["PORT"]}/v1/api/', // senin API base adresin
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        return status != null &&
            status < 500; // 500 ve üstü hataları exception yap
      },
    ),
  );

  static Dio get instance => _dio;
}
