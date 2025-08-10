import 'package:imdb_app/data/model/user/user_model.dart';

class AuthResponse {
  final String token;
  final UserModel user;
  final int expiresAt;
  final String message;

  AuthResponse({
    required this.token,
    required this.user,
    required this.expiresAt,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: UserModel.fromJson(json['user']),
      expiresAt: json['expires_at'],
      message: json['message'],
    );
  }
}
