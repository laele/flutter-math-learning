import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';

class ScoreBadge extends StatelessWidget {
  final double widthSize;
  final double heightSize;
  final bool showBackground;
  final Widget child;
  const ScoreBadge({super.key, required this.widthSize, required this.heightSize, required this.child, this.showBackground = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: heightSize,
      decoration: showBackground
          ? BoxDecoration(
              color: AppColors.onPrimaryBorder,
              borderRadius: BorderRadius.circular(12.0),
            )
          : null,
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Image.asset(
                'lib/core/assets/images/star_1.png',
                color: Colors.white,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
