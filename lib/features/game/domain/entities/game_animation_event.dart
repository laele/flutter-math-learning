import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/entities/character_animation_type.dart';

class GameAnimationEvent extends Equatable {
  final CharacterAnimationType type;
  final int id;

  const GameAnimationEvent({required this.type, required this.id});

  @override
  List<Object?> get props => [type, id];
}
