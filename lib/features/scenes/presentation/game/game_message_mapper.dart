import 'package:flutter_math_app/features/dialog_message/domain/enums/message_key_type.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_mode.dart';

class GameMessageMapper {
  static MessageKeyType messageKeyFor(GameMode mode) => switch (mode) {
    GameMode.add => MessageKeyType.questionAdd,
    GameMode.sub => MessageKeyType.questionSub,
    GameMode.mult => MessageKeyType.questionMult,
    GameMode.div => MessageKeyType.questionMult,
  };
}
