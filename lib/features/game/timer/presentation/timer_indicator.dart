import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/features/game/timer/presentation/cubit/timer_cubit.dart';
import 'package:flutter_math_app/features/game/timer/presentation/widgets/timer_border_painter.dart';

class TimerIndicator extends StatelessWidget {
  const TimerIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      buildWhen: (previous, current) {
        if (previous.remainingTime != current.remainingTime || previous.isRunning != current.isRunning) {
          return true;
        }
        return false;
      },
      builder: (BuildContext context, TimerState state) {
        return TimerAnimated(
          isVisible: !state.isRunning,
          progress: state.progress,
        );
      },
    );
  }
}

class TimerAnimated extends StatefulWidget {
  final double progress;
  final bool isVisible;
  const TimerAnimated({
    super.key,
    required this.progress,
    required this.isVisible,
  });

  @override
  State<TimerAnimated> createState() => _TimerAnimatedState();
}

class _TimerAnimatedState extends State<TimerAnimated> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
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
  void didUpdateWidget(covariant TimerAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
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
      child: CustomPaint(
        foregroundPainter: TimerBorderPainter(progress: widget.progress),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: Pulse(
              animate: widget.progress > 0.05,
              infinite: true,
              duration: const Duration(milliseconds: 1200),
              child: Icon(
                Icons.timer,
                color: AppColors.onPrimary,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
