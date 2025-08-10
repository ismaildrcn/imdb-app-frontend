import 'package:imdb_app/data/model/user/user_model.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:imdb_app/features/profile/utils/auth_response.dart';

class SecureStorage {
  static final storage = FlutterSecureStorage();

  static Future<void> saveUser(AuthResponse response) async {
    print("Token: ${response.token}");
    await storage.write(key: 'user_token', value: response.token);
    await storage.write(key: 'user_email', value: response.user.email);
    await storage.write(
      key: 'expires_at',
      value: response.expiresAt.toString(),
    );
  }

  static Future<UserModel?> getUser() async {
    final token = await storage.read(key: 'user_token');
    final email = await storage.read(key: 'user_email');

    if (token == null || email == null) return null;

    return UserModel(
      fullName: '',
      email: email,
      password: '',
      role: '',
      avatar: '',
      phone: '',
      token: token,
    );
  }

  static Future<void> clearAll() async {
    await storage.deleteAll();
  }

  static FlutterSecureStorage get instance => storage;
}
