// import 'package:flutter/material.dart';

// class AppTheme {
//   // Colors
//   static const Color primaryColor = Color(0xFF7B8DCF);
//   static const Color selectedColor = Color(0xFF243882);

//   // Themedata
//   static final ThemeData light = ThemeData(
//     primaryColor: primaryColor,
//     colorScheme: ColorScheme.light(
//       primary: primaryColor,
//       secondary: selectedColor,
//     ),
//     scaffoldBackgroundColor: Colors.white,

//     textTheme: const TextTheme(
//       headlineMedium: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//       titleLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//       bodyLarge: TextStyle(color: primaryColor, fontSize: 16),
//       titleMedium: TextStyle(color: selectedColor, fontSize: 16),
//     ),

//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.green,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     ),

//     inputDecorationTheme: InputDecorationTheme(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: selectedColor),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: selectedColor, width: 2),
//       ),
//       prefixIconColor: selectedColor,
//       hintStyle: const TextStyle(color: selectedColor, fontSize: 16),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryDark,
    ),
    scaffoldBackgroundColor: Colors.white,

    textTheme: AppTextStyles.textTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Consider using AppColors.secondary
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primaryDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
      ),
      prefixIconColor: AppColors.primaryDark,
      hintStyle: const TextStyle(color: AppColors.primaryDark, fontSize: 16),
    ),
  );
}
