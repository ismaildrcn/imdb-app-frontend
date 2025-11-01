import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imdb_app/features/profile/utils/storage.dart';


class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _buildBaseUrl(),
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

  static void addTokenInterceptor() {
    instance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  static String _buildBaseUrl() {
    final baseUrl = dotenv.env["BASE_URL"] ?? "http://localhost";
    final port = dotenv.env["PORT"] ?? "8000";

    // Debug için log ekleyelim
    print('DEBUG - BASE_URL: $baseUrl');
    print('DEBUG - PORT: $port');

    // Eğer baseUrl zaten http:// veya https:// ile başlıyorsa, olduğu gibi kullan
    String fullBaseUrl;
    if (baseUrl.startsWith('http://') || baseUrl.startsWith('https://')) {
      fullBaseUrl = baseUrl;
    } else {
      fullBaseUrl = 'http://$baseUrl';
    }

    final finalUrl = '$fullBaseUrl:$port/v1/api';
    print('DEBUG - Final API URL: $finalUrl');
    return finalUrl;
  }

  static Dio get instance => _dio;
}
