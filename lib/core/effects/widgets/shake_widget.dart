import 'package:flutter/material.dart';

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final double intensity;
  final Duration duration;
  final Duration reverseDuration;

  const ShakeWidget({
    super.key,
    required this.child,
    this.intensity = 12.0,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration = const Duration(milliseconds: 125),
  });

  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: widget.duration, reverseDuration: widget.reverseDuration);
  late final Animation<double> _animation =
      Tween(
        begin: 1.0,
        end: 1.04,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeOut,
        ),
      );

  void shake() async {
    await _controller.forward(from: 0);
    await _controller.reverse();
    ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
