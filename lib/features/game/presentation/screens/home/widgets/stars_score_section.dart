import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';

class StarsScoreSection extends StatelessWidget {
  const StarsScoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BounceInDown(
            delay: Duration(milliseconds: 200),
            child: StarItem(
              width: 60,
              height: 60,
              isCompleted: true,
            ),
          ),
          SizedBox(width: 8),
          BounceInDown(
            child: StarItem(width: 120, height: 120, isCompleted: true),
          ),
          SizedBox(width: 8),
          BounceInDown(
            delay: Duration(milliseconds: 400),

            child: StarItem(width: 60, height: 60, isCompleted: false),
          ),
        ],
      ),
    );
  }
}

class StarItem extends StatelessWidget {
  final double width;
  final double height;
  final bool isCompleted;
  const StarItem({super.key, required this.width, required this.height, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimaryBorder,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: width,
          height: height,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'lib/core/assets/images/star.png',
              color: isCompleted ? null : const Color.fromARGB(255, 65, 65, 65),
            ),
          ),
        ),
      ),
    );
  }
}
