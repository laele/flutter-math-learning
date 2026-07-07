part of 'game_cubit.dart';

enum PetAnimation { idle, thinking, failed, success }

class GameState extends Equatable {
  final PetAnimation petAnimation;
  final String? message;
  const GameState({
    required this.petAnimation,
    this.message,
  });

  GameState copyWith({
    PetAnimation? petAnimation,
    String? message,
  }) {
    return GameState(
      petAnimation: petAnimation ?? this.petAnimation,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
    petAnimation,
    message,
  ];
}
