import 'package:flutter/material.dart';

class AppTheme {
  // Tekrar nesne oluşturulmasını engellemek için
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: false,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF12CDD9),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFFEEEEEE),
      secondary: Color(0xFF000000),
      onSecondary: Color(0xFF333333),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Color(0xFFE3E8F3)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      unselectedIconTheme: IconThemeData(
        // Seçili olmayan ikon rengi
        color: Colors.grey[500], // Daha soluk gri
        size: 24,
      ),
      selectedLabelStyle: TextStyle(
        // Seçili yazı stili
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: false,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF12CDD9), // Orijinal primary renginin daha koyu tonu
      surface: Color(0xFF121212), // Dark theme için standart surface rengi
      onSurface: Color(0xFF1E1E1E), // Daha açık bir arkaplan
      secondary: Color(0xFFBDBDBD), // Light gri, siyah yerine
      onSecondary: Color(0xFFE0E0E0), // Daha açık gri
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: Color(0xFF7D8BA3),
      ), // Daha koyu bir mavi-gri
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFEEEEEE), // Tüm Icon widget'ları için renk
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      unselectedIconTheme: IconThemeData(
        // Seçili olmayan ikon rengi
        color: Colors.grey[500], // Daha soluk gri
        size: 24,
      ),
      selectedLabelStyle: TextStyle(
        // Seçili yazı stili
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ), // Dark theme için daha uygun koyu renk
    ),
    scaffoldBackgroundColor: Color(
      0xFF121212,
    ), // Dark theme için standart arkaplan
  );
}
