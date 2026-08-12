import 'package:flutter/material.dart';

class ScoreBadge extends StatelessWidget {
  final double widthSize;
  final double heightSize;
  final Widget child;
  const ScoreBadge({super.key, required this.widthSize, required this.heightSize, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: heightSize,
      clipBehavior: Clip.none,
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
    );
  }
}
