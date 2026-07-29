import 'package:equatable/equatable.dart';

enum SoundType { correct, incorrect, levelUp, levelDown }

class GameSoundEvent extends Equatable {
  final SoundType type;
  final int id;

  GameSoundEvent({required this.type, required this.id});

  @override
  List<Object?> get props => [type, id];
}
