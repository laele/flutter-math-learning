import 'package:flutter_math_app/features/dialog_message/domain/enums/message_key_type.dart';

abstract interface class DialogMessageRepository {
  String getMessage({required MessageKeyType key});
  void setLocale({required String languageCode});
}
