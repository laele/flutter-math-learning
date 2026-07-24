import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/effects/game_effect_type.dart';

class GameEffectEvent extends Equatable {
  final GameEffectType type;
  final int id;

  GameEffectEvent({required this.type, required this.id});

  @override
  List<Object?> get props => [type, id];
}
