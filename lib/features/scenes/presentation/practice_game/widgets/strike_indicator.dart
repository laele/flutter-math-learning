import 'package:flutter/material.dart';

class StrikeIndicatorAnimated extends StatefulWidget {
  final double widthSize;
  final double heightSize;
  final Color color;
  const StrikeIndicatorAnimated({super.key, required this.widthSize, required this.heightSize, required this.color});

  @override
  State<StrikeIndicatorAnimated> createState() => _StrikeIndicatorAnimatedState();
}

class _StrikeIndicatorAnimatedState extends State<StrikeIndicatorAnimated> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _scale =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(
              begin: 1.0,
              end: 1.95,
            ),
            weight: 55,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 1.95,
              end: 0.8,
            ),
            weight: 35,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 0.8,
              end: 1,
            ),
            weight: 20,
          ),
        ]).animate(
          _animation,
        );
  }

  Future<void> playAnimation() async {
    await _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(covariant StrikeIndicatorAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.color != widget.color) {
      playAnimation();
      if (!mounted) return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: child,
        );
      },
      child: Container(
        width: widget.widthSize,
        height: widget.heightSize,
        clipBehavior: Clip.none,
        child: Center(
          child: Image.asset('lib/core/assets/images/cross.png', color: widget.color),
        ),
      ),
    );
  }
}
