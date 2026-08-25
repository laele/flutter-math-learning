import 'package:flutter_math_app/features/game/domain/entities/min_max_tier_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

class DifficultyTiers {
  static const Map<OperationType, List<MinMaxTierEntity>> byMode = {
    /*OperationType.learnNumbers: [
      MinMaxTierEntity(min: 0, max: 10), // Level 0
      MinMaxTierEntity(min: 1, max: 20), // Level 1
      MinMaxTierEntity(min: 1, max: 50), // Level 2
      MinMaxTierEntity(min: 1, max: 99), // Level 3
    ],*/
    OperationType.add: [
      MinMaxTierEntity(min: 1, max: 10, weight: 1.0), // Level 0
      MinMaxTierEntity(min: 1, max: 20, weight: 1.2), // Level 1
      MinMaxTierEntity(min: 1, max: 50, weight: 1.3), // Level 2
      MinMaxTierEntity(min: 1, max: 100, weight: 1.5), // Level 3
    ],
    OperationType.sub: [
      MinMaxTierEntity(min: 1, max: 10, weight: 1.0), // Level 0
      MinMaxTierEntity(min: 1, max: 20, weight: 1.2), // Level 1
      MinMaxTierEntity(min: 1, max: 50, weight: 1.3), // Level 2
      MinMaxTierEntity(min: 1, max: 100, weight: 1.5), // Level 3
    ],
    OperationType.mult: [
      MinMaxTierEntity(min: 1, max: 5, weight: 1.0), // Level 0
      MinMaxTierEntity(min: 1, max: 10, weight: 1.2), // Level 1
      MinMaxTierEntity(min: 1, max: 12, weight: 1.3), // Level 2
      MinMaxTierEntity(min: 1, max: 15, weight: 1.4), // Level 3
    ],
    OperationType.div: [
      MinMaxTierEntity(min: 1, max: 5, weight: 1.0), // Level 0
      MinMaxTierEntity(min: 1, max: 10, weight: 1.1), // Level 1
      MinMaxTierEntity(min: 1, max: 12, weight: 1.2), // Level 2
      MinMaxTierEntity(min: 1, max: 20, weight: 1.3), // Level 3
    ],
  };
}
