import 'package:imdb_app/data/services/user_service.dart';

class UserModel {
  final String fullName;
  final String email;
  final String? password;
  final String role;
  final String? avatar;
  final String? phone;
  final String? token;
  final String? expires;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
    required this.phone,
    this.token,
    this.expires,
  });

  static final UserService _userService = UserService();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      avatar: json['avatar'],
      phone: json['phone'],
      token: json['token'],
      expires: json['expires'],
    );
  }

  static Future<UserModel?> fromToken(String token) async {
    // Token ile kullanıcı bilgilerini al

    final user = await _userService.getUserByToken(token);
    if (user != null) {
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'role': role,
      'avatar': avatar,
      'phone': phone,
    };
  }
}
