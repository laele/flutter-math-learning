import 'package:flutter/material.dart';

class AnimatedOverlay extends StatefulWidget {
  final Widget child;
  const AnimatedOverlay({super.key, required this.child});

  @override
  State<AnimatedOverlay> createState() => AnimatedOverlayState();
}

class AnimatedOverlayState extends State<AnimatedOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scale =
        TweenSequence<double>(
          [
            TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 40),
          ],
        ).animate(
          CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1)),
        );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> playOutAnimation() async {
    await _controller.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value,
          child: Transform.scale(
            scale: _scale.value,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 500,
                  ),
                  child: Card(
                    color: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(
                        36.0,
                      ),
                    ),
                    elevation: 25,
                    child: Padding(padding: const EdgeInsets.all(16.0), child: widget.child),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
