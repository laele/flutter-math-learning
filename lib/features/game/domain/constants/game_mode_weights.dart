import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

class GameModeWeights {
  static const Map<OperationType, double> _weights = {
    OperationType.add: 1.0,
    OperationType.div: 1.25,
    OperationType.sub: 1.0,
    OperationType.mult: 1.25,
  };

  static double of({required OperationType mode}) => _weights[mode] ?? 1.0;
}
