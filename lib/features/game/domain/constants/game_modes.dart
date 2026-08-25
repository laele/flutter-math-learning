import 'package:flutter_math_app/features/game/domain/entities/game_mode_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

class operationTypes {
  static List<operationTypeEntity> items = [
    //operationTypeEntity(operationType: OperationType.tutorial, title: 'Tutorial'),
    //operationTypeEntity(operationType: OperationType.learnNumbers, title: 'Learn Numbers'),
    operationTypeEntity(operationType: OperationType.add, title: 'Add'),
    operationTypeEntity(operationType: OperationType.sub, title: 'Substract'),
    operationTypeEntity(operationType: OperationType.div, title: 'Division'),
    operationTypeEntity(
      operationType: OperationType.mult,
      title: 'Multiplicacion',
    ),
    //operationTypeEntity(operationType: OperationType.mix, title: 'Mixed Mode'),
  ];
}
