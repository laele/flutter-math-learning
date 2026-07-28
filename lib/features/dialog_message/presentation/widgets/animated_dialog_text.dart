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

class _AnimatedDialogTextState extends State<AnimatedDialogText> {
  double _scale = 1;

  @override
  void initState() {
    super.initState();
    _bounce();
  }

  void _bounce() async {
    setState(() => _scale = 0.55);

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    setState(() => _scale = 1.55);

    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;

    setState(() => _scale = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedScale(
        scale: _scale,
        alignment: Alignment.bottomCenter,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeOutBack,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.upperMessage != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.upperMessage.toString(),
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
                      key: ValueKey(widget.message),
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          widget.message!,
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
