part of 'character_cubit.dart';

class CharacterState extends Equatable {
  final bool controllerReady;
  final CharacterAnimationEvent? animationEvent;

  const CharacterState({
    this.animationEvent,
    this.controllerReady = false,
  });

  CharacterState copyWith({
    CharacterAnimationEvent? animationEvent,
    bool? controllerReady,
  }) {
    return CharacterState(
      controllerReady: controllerReady ?? this.controllerReady,
      animationEvent: animationEvent ?? this.animationEvent,
    );
  }

  @override
  List<Object?> get props => [animationEvent, controllerReady];
}
