import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_math_app/core/widgets/custom_icon.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final String assetIconRoute;
  final VoidCallback function;

  const MenuButton({super.key, required this.title, required this.assetIconRoute, required this.function});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: function,
          label: Text(title, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white)),
          icon: CustomIcon(
            assetRoute: assetIconRoute,
            useColor: false,
            size: IconSize.lg,
          ),
        ),
      ],
    );
  }
}
