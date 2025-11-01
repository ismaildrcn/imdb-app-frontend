import 'package:imdb_app/data/services/user_service.dart';

class UserModel {
  final String fullName;
  final String email;
  final String? phone;
  final bool? isActive;
  final bool? isVerified;
  final String? avatar;
  final String? password;
  final String role;
  final String? createdAt;
  final String? token;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
    required this.phone,
    this.isActive,
    this.isVerified,
    this.createdAt,
    this.token,
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
      isActive: json['is_active'],
      isVerified: json['is_verified'],
      createdAt: json['created_at'],
      token: json['token'],
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
    return {'full_name': fullName, 'email': email, 'password': password};
  }
}
