import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';

class ScoreBadge extends StatelessWidget {
  final double widthSize;
  final double heightSize;
  final bool best;
  final Widget child;
  const ScoreBadge({super.key, required this.widthSize, required this.heightSize, required this.child, this.best = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: heightSize,
      decoration: best
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
                !best ? 'lib/core/assets/images/star_1.png' : 'lib/core/assets/images/star_badge_3.png',
                color: best ? null : Colors.white,
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
