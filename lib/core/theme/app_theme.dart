import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    final textTheme = GoogleFonts.rubikSprayPaintTextTheme().apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    );
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.appBackground,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.appBackground,
        primaryContainer: Colors.yellow,
        onPrimaryContainer: AppColors.appBackground,
      ),

      appBarTheme: AppBarTheme(
        color: AppColors.appBackgroundGradientVariant,
      ),
    );
  }
}
