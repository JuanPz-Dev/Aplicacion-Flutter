import 'package:flutter/material.dart';

class AppTheme {
  static const background = Color(0xFF0E0F11);
  static const surface = Color(0xFF1A1B1E);
  static const textSecondary = Color(0xFF8E8E93);

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          surface: surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
      );
}