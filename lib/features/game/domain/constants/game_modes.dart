import 'package:flutter_math_app/features/game/domain/entities/game_mode_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

class GameModes {
  static List<GameModeEntity> items = [
    //GameModeEntity(gameMode: OperationType.tutorial, title: 'Tutorial'),
    //GameModeEntity(gameMode: OperationType.learnNumbers, title: 'Learn Numbers'),
    GameModeEntity(gameMode: OperationType.add, title: 'Add'),
    GameModeEntity(gameMode: OperationType.sub, title: 'Substract'),
    GameModeEntity(gameMode: OperationType.div, title: 'Division'),
    GameModeEntity(gameMode: OperationType.mult, title: 'Multiplicacion'),
    //GameModeEntity(gameMode: OperationType.mix, title: 'Mixed Mode'),
  ];
}
