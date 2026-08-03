// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedDialogText extends StatefulWidget {
  final String message;
  final String? upperMessage;

  const AnimatedDialogText({
    Key? key,
    required this.message,
    required this.upperMessage,
  }) : super(key: key);

  @override
  State<AnimatedDialogText> createState() => _AnimatedDialogTextState();
}

class _AnimatedDialogTextState extends State<AnimatedDialogText> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _showScale;
  late final Animation<double> _hideScale;
  late Animation<double> _scale;

  String? _displayedMessage;
  String? _displayedUpperMessage;
  bool _isAnimating = false;

  //DialogAnimationType _animationType = DialogAnimationType.show;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    _showScale =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(
              begin: 0.0,
              end: 1.25,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 35,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 1.25,
              end: 0.95,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 45,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 0.95,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 30,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 1, curve: Curves.easeOut),
          ),
        );
    _hideScale = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scale = _showScale;

    _displayedMessage = widget.message;
    _displayedUpperMessage = widget.upperMessage;

    _showAnimation();
  }

  Future<void> _showAnimation() async {
    setState(() {
      _scale = _showScale;
    });
    await _controller.forward(from: 0);
  }

  Future<void> _hideAnimation() async {
    setState(() {
      _scale = _hideScale;
    });
    await _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedDialogText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.message != widget.message) {
      _changeMessage();
    }
  }

  Future<void> _changeMessage() async {
    if (_isAnimating) return;

    _isAnimating = true;

    try {
      await _hideAnimation();

      if (!mounted) return;

      setState(() {
        _displayedMessage = widget.message;
        _displayedUpperMessage = widget.upperMessage;
      });

      await _showAnimation();
    } finally {
      _isAnimating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            alignment: Alignment.bottomCenter,
            child: child,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_displayedUpperMessage != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _displayedUpperMessage.toString(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            SizedBox(height: 8.0),
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentGeometry.bottomCenter,
              children: [
                Container(
                  //color: Colors.yellow,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      32.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AnimatedTextKit(
                      key: ValueKey(_displayedMessage),
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          _displayedMessage!,
                          textAlign: TextAlign.center,
                          textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  child: Transform.rotate(
                    angle: 3.1416 / 4,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
