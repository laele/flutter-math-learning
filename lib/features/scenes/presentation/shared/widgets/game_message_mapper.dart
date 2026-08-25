import 'package:flutter_math_app/features/dialog_message/domain/enums/message_key_type.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

class GameMessageMapper {
  static MessageKeyType messageKeyFor(OperationType mode) => switch (mode) {
    OperationType.add => MessageKeyType.questionAdd,
    OperationType.sub => MessageKeyType.questionSub,
    OperationType.mult => MessageKeyType.questionMult,
    OperationType.div => MessageKeyType.questionDiv,
  };
}
