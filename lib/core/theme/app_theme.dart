import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    final textTheme = GoogleFonts.dynaPuffTextTheme().apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
    );
    return ThemeData(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.appBackground,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.appBackground,

        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,

        primaryContainer: AppColors.primary,
        onPrimaryContainer: AppColors.onPrimary,
      ),

      appBarTheme: AppBarTheme(
        color: AppColors.appBackgroundGradientVariant,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        enableFeedback: false,
      ),
    );
  }
}
