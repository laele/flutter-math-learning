import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData light() {
    /*final textTheme = TextTheme()
    /*GoogleFonts.dynaPuffTextTheme().apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
    )*/;*/
    return ThemeData(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.appBackground,
      fontFamily: 'Qilka',
      //textTheme: textTheme,
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
        //enableFeedback: false,
      ),

      dialogTheme: DialogThemeData(constraints: BoxConstraints(maxWidth: 400)),
    );
  }
}
