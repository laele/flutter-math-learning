import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppMainTitleText extends StatelessWidget {
  const AppMainTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          //color: AppColors.primary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            'MathHop',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontFamily: 'Gocake',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 72,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                ),
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(0, 0),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
