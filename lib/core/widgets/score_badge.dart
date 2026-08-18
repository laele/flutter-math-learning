import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/features/game/score/widgets/text_score_animated.dart';

class ScoreBadge extends StatelessWidget {
  final double widthSize;
  final double heightSize;
  final bool showBackground;
  final String? text;
  const ScoreBadge({super.key, required this.widthSize, required this.heightSize, this.text, this.showBackground = false});

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
            text != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: TextScoreAnimated(
                          scoreText: '${text}',
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
