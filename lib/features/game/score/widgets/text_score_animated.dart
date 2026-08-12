// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TextScoreAnimated extends StatefulWidget {
  final String scoreText;

  const TextScoreAnimated({
    Key? key,
    required this.scoreText,
  }) : super(key: key);

  @override
  State<TextScoreAnimated> createState() => _TextScoreAnimatedState();
}

class _TextScoreAnimatedState extends State<TextScoreAnimated> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _scale =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(
              begin: 1.0,
              end: 0.6,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 15,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 0.6,
              end: 3.6,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 45,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 3.6,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 40,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 1, curve: Curves.easeOut),
          ),
        );
  }

  Future<void> _playAnimation() async {
    await _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TextScoreAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scoreText != this.widget.scoreText) {
      // Do Animation
      _playAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: child,
      ),
      child: Text(
        widget.scoreText,
        softWrap: true,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
