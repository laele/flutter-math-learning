import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

class GameOperationStatsEntry extends Equatable {
  final OperationType operationType;
  final GameStatsEntity stats;

  GameOperationStatsEntry({required this.operationType, required this.stats});

  @override
  List<Object?> get props => [
    operationType,
    stats,
  ];
}
