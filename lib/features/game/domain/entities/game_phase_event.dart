import 'package:flutter_math_app/core/entities/domain_event.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';

class GamePhaseEvent extends DomainEvent {
  final GamePhase gamePhase;

  const GamePhaseEvent({required super.id, required this.gamePhase});

  @override
  List<Object?> get props => [
    ...super.props,
    gamePhase,
  ];
}
