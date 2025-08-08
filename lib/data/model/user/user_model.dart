class UserModel {
  final String fullName;
  final String email;
  final String? password;
  final String role;
  final String? avatar;
  final String? phone;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      avatar: json['avatar'],
      phone: json['phone'],
    );
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
