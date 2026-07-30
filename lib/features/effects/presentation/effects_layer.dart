import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_math_app/features/effects/domain/enums/effect_type.dart';
import 'package:flutter_math_app/features/effects/presentation/cubit/effects_cubit.dart';

class EffectsLayer extends StatefulWidget {
  const EffectsLayer({super.key});

  @override
  State<EffectsLayer> createState() => _EffectsLayerState();
}

class _EffectsLayerState extends State<EffectsLayer> {
  Timer? _t1, _t2, _t3;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _t1?.cancel();
    _t2?.cancel();
    _t3?.cancel();
    super.dispose();
  }

  void _handleEffect(EffectsType effect) {
    switch (effect) {
      case EffectsType.stars:
        _playStars();
      case EffectsType.confetti:
        _playConfetti();
      case EffectsType.shake:
        break;
    }
  }

  void _playConfetti() {
    if (!mounted) return;
    Confetti.launch(
      context,
      options: _confettiOptions.copyWith(
        particleCount: 100,
        spread: 70,
        y: 0.6,
        scalar: 2.5,
        angle: 90.0,
        gravity: 1.00,
      ),
    );
  }

  void _playStars() {
    void shoot() {
      if (!mounted) return;
      Confetti.launch(
        context,
        options: _confettiOptions.copyWith(
          particleCount: 20,
          scalar: 1.75,
        ),
        particleBuilder: (index) => Star(),
      );
      Confetti.launch(
        context,
        options: _confettiOptions.copyWith(
          particleCount: 10,
          scalar: 1,
        ),
        particleBuilder: (index) => Star(),
      );
    }

    _t1 = Timer(Duration.zero, shoot);
    _t2 = Timer(const Duration(milliseconds: 100), shoot);
    _t3 = Timer(const Duration(milliseconds: 200), shoot);
  }

  static const _confettiOptions = ConfettiOptions(
    spread: 360,
    ticks: 50,
    gravity: 1,
    decay: 0.94,
    startVelocity: 30,
    angle: 0.0,
    colors: [
      Color(0xffFFE400),
      Color(0xffFFBD00),
      Color(0xffE89400),
      Color(0xffFFCA6C),
      Color(0xffFDFFB8),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<EffectsCubit, EffectsState>(
      listenWhen: (previous, current) {
        if ((previous.effectsEvent != current.effectsEvent) && current.effectsEvent != null) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        // ignore: void_checks
        return _handleEffect(state.effectsEvent!.type);
      },
      child: const SizedBox.shrink(),
    );
  }
}
