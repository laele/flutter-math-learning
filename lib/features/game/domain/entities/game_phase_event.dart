import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';

class GamePhaseEvent extends Equatable {
  final int id;
  final GamePhase gamePhase;

  const GamePhaseEvent({required this.id, required this.gamePhase});

  @override
  List<Object?> get props => [
    id,
    gamePhase,
  ];
}
