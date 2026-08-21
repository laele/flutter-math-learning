import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';

class AppFilledButton extends StatelessWidget {
  final String title;
  final VoidCallback function;
  const AppFilledButton({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: AppColors.onPrimaryBorder),
      onPressed: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
        ],
      ),
    );
  }
}
