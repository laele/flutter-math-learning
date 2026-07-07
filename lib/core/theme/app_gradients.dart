import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';

class AppGradients {
  static const LinearGradient background = LinearGradient(
    begin: AlignmentGeometry.bottomCenter,
    end: AlignmentDirectional.topCenter,
    colors: [
      AppColors.appBackgroundGradient,
      AppColors.appBackgroundGradientVariant,
    ],
  );
}
