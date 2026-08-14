import 'package:flutter/widgets.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';

enum IconSize { sm, md, lg }

class CustomIcon extends StatelessWidget {
  final String assetRoute;
  final Color color;
  final bool useColor;
  final IconSize size;

  const CustomIcon({
    super.key,
    required this.assetRoute,
    this.color = AppColors.iconColor,
    this.useColor = true,
    this.size = IconSize.md,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize;

    switch (size) {
      case IconSize.sm:
        iconSize = 16.0;
      case IconSize.md:
        iconSize = 24.0;
      case IconSize.lg:
        iconSize = 32.0;
    }

    return SizedBox(
      height: iconSize,
      width: iconSize,
      child: Image.asset(
        assetRoute,
        color: useColor ? color : null,
      ),
    );
  }
}
