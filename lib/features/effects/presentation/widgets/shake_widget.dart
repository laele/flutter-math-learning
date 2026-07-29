import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/effects/domain/enums/effect_type.dart';
import 'package:flutter_math_app/features/effects/presentation/cubit/effects_cubit.dart';

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
  late final AnimationController _controller;
  late final Animation<double> _animation;

  void _shake() async {
    await _controller.forward(from: 0);
    await _controller.reverse();
    ;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration, reverseDuration: widget.reverseDuration);
    _animation =
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EffectsCubit, EffectsState>(
      listenWhen: (previous, current) {
        if ((previous.effectsEvent != current.effectsEvent) && current.effectsEvent != null && current.effectsEvent?.type == EffectsType.shake) {
          return true;
        }
        return false;
      },
      listener: (BuildContext context, EffectsState state) {
        _shake();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}
