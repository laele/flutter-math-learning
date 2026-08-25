import 'package:flutter_math_app/features/game/domain/constants/game_mode_weights.dart';
import 'package:flutter_math_app/features/game/domain/entities/min_max_tier_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

class QuestionWeightCalculator {
  static double calculate({
    required OperationType gameMode,
    required MinMaxTierEntity tier,
  }) {
    return GameModeWeights.of(mode: gameMode) * tier.weight;
  }
}
