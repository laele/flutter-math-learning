import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_math_app/core/effects/game_effect_type.dart';

abstract interface class EffectsPlayer {
  void play(GameEffectType effect, BuildContext context);
}

class EffectsPlayerImpl implements EffectsPlayer {
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
  void play(GameEffectType effect, BuildContext context) {
    switch (effect) {
      case GameEffectType.stars:
        _playStars(context);
      case GameEffectType.confetti:
        _playConfetti(context);
        break;
    }
  }

  void _playStars(BuildContext context) {
    shoot() {
      Confetti.launch(
        context,
        options: _confettiOptions.copyWith(particleCount: 20, scalar: 1.7),
        particleBuilder: (index) => Star(),
      );
      Confetti.launch(
        context,
        options: _confettiOptions.copyWith(
          particleCount: 10,
          scalar: 0.65,
        ),
        particleBuilder: (index) => Star(),
      );
    }

    Timer(Duration.zero, shoot);
    Timer(const Duration(milliseconds: 100), shoot);
    Timer(const Duration(milliseconds: 200), shoot);
  }

  void _playConfetti(BuildContext context) {
    Confetti.launch(
      context,
      options: _confettiOptions.copyWith(particleCount: 100, spread: 70, y: 0.6, scalar: 2.5, angle: 90.0),
    );
  }
}
