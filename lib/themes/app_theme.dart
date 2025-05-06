import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF7B8DCF);
  static const Color selectedColor = Color(0xFF243882);

  // Themedata
  static final ThemeData light = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: selectedColor,
    ),
    scaffoldBackgroundColor: Colors.white,

    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: primaryColor, fontSize: 16),
      titleMedium: TextStyle(color: selectedColor, fontSize: 16),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: selectedColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: selectedColor, width: 2),
      ),
      prefixIconColor: selectedColor,
      hintStyle: const TextStyle(color: selectedColor, fontSize: 16),
    ),
  );
}
