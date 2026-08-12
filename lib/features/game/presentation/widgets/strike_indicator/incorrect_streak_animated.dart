import 'package:flutter/material.dart';
import 'package:flutter_math_app/features/scenes/presentation/practice_game/widgets/strike_indicator.dart';

class IncorrectStreakAnimated extends StatefulWidget {
  final bool isVisible;
  final int incorrectStreak;
  const IncorrectStreakAnimated({super.key, required this.isVisible, required this.incorrectStreak});

  @override
  State<IncorrectStreakAnimated> createState() => _IncorrectStreakAnimatedState();
}

class _IncorrectStreakAnimatedState extends State<IncorrectStreakAnimated> with SingleTickerProviderStateMixin {
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
              begin: 0.0,
              end: 1.65,
            ),
            weight: 55,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 1.65,
              end: 0.9,
            ),
            weight: 35,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 0.9,
              end: 1,
            ),
            weight: 20,
          ),
        ]).animate(
          _animation,
        );
  }

  Future<void> playInAnimation() async {
    await _controller.forward(from: 0);
  }

  Future<void> playOutAnimation() async {
    await _controller.reverse(from: 1);
  }

  @override
  void didUpdateWidget(covariant IncorrectStreakAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isVisible != widget.isVisible) {
      if (!widget.isVisible) {
        playOutAnimation();
      } else {
        playInAnimation();
      }
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
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: child,
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            StrikeIndicatorAnimated(widthSize: 40, heightSize: 40, color: widget.incorrectStreak > 0 ? Colors.red : Colors.black38),
            SizedBox(width: 8.0),
            StrikeIndicatorAnimated(widthSize: 40, heightSize: 40, color: widget.incorrectStreak > 1 ? Colors.red : Colors.black38),
            SizedBox(width: 8.0),
            StrikeIndicatorAnimated(widthSize: 40, heightSize: 40, color: widget.incorrectStreak > 2 ? Colors.red : Colors.black38),
          ],
        ),
      ),
    );
  }
}
