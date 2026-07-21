import 'package:equatable/equatable.dart';

enum GameSoundType { correct, incorrect, levelUp, levelDown }

class GameSoundEvent extends Equatable {
  final GameSoundType type;
  final int id;

  GameSoundEvent({required this.type, required this.id});

  @override
  List<Object?> get props => [type, id];
}
