import 'package:flutter_math_app/features/dialog_message/domain/enums/message_key_type.dart';

class MessagePoolEntity {
  final Map<MessageKeyType, List<String>> messages;
  const MessagePoolEntity({required this.messages});

  List<String> forKey(MessageKeyType key) => messages[key] ?? const [];
}
