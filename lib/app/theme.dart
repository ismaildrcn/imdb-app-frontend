import 'package:flutter/material.dart';

class AppTheme {
  // Tekrar nesne oluşturulmasını engellemek için
  AppTheme._();
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: false,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFF2C94C),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFFFFF8E3),
      secondary: Color(0xFF000000),
      onSecondary: Color(0xFF333333),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Color(0xFFE3E8F3)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black, // İstediğiniz renk
    ),
  );
}
