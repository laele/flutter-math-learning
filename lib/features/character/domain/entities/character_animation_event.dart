import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/character/domain/enums/character_animation_type.dart';

class CharacterAnimationEvent extends Equatable {
  final CharacterAnimationType type;
  final int id;

  const CharacterAnimationEvent({required this.type, required this.id});

  @override
  List<Object?> get props => [type, id];
}
