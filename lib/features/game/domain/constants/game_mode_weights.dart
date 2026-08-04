import 'package:flutter_math_app/features/game/domain/enums/game_mode.dart';

class GameModeWeights {
  static const Map<GameMode, double> _weights = {
    GameMode.add: 1.0,
    GameMode.div: 1.25,
    GameMode.sub: 1.0,
    GameMode.mult: 1.25,
  };

  static double of({required GameMode mode}) => _weights[mode] ?? 1.0;
}
