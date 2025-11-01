import 'package:imdb_app/data/model/user/user_model.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:imdb_app/features/profile/utils/auth_response.dart';

class SecureStorage {
  static final storage = FlutterSecureStorage();

  static Future<void> saveUser(AuthResponse response) async {
    await storage.write(key: 'user_token', value: response.token);
    await storage.write(key: 'user_email', value: response.user.email);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'user_token');
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
      isActive: false,
      isVerified: false,
      createdAt: '',
      token: token,
    );
  }

  static Future<void> clearAll() async {
    await storage.deleteAll();
  }

  static FlutterSecureStorage get instance => storage;
}
