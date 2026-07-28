part of 'character_cubit.dart';

class CharacterState extends Equatable {
  final CharacterAnimationEvent? animationEvent;

  const CharacterState({
    this.animationEvent,
  });

  CharacterState copyWith({
    CharacterAnimationEvent? animationEvent,
  }) {
    return CharacterState(
      animationEvent: animationEvent ?? this.animationEvent,
    );
  }

  @override
  List<Object?> get props => [animationEvent];
}
