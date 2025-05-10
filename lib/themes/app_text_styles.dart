import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDark,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.primary),
    bodyMedium: TextStyle(fontSize: 16),
    bodySmall: TextStyle(fontSize: 14, color: Colors.grey),
  );
}
