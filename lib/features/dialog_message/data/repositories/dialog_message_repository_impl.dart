import 'package:flutter_math_app/features/dialog_message/domain/entities/message_pool_entity.dart';
import 'package:flutter_math_app/features/dialog_message/domain/enums/message_key_type.dart';
import 'package:flutter_math_app/features/dialog_message/domain/repositories/dialog_message_repository.dart';
import 'package:flutter_math_app/features/dialog_message/domain/services/message_variation_picker.dart';

class DialogMessageRepositoryImpl implements DialogMessageRepository {
  final Map<String, MessagePoolEntity> _poolsByLocale;
  final MessageVariationPicker _picker;
  String _currentLocale;

  DialogMessageRepositoryImpl({
    required Map<String, MessagePoolEntity> poolsByLocale,
    MessageVariationPicker? picker,
  }) : _poolsByLocale = poolsByLocale,
       _picker = picker ?? MessageVariationPicker(),
       _currentLocale = poolsByLocale.keys.first; // 'en by default'

  @override
  void setLocale({required String languageCode}) {
    _currentLocale = _poolsByLocale.containsKey(languageCode) ? languageCode : _poolsByLocale.keys.first;
  }

  @override
  String getMessage({required MessageKeyType key, String? playerName, String? number}) {
    final pool = _poolsByLocale[_currentLocale] ?? _poolsByLocale.values.first;
    final rawMessage = _picker.pick(pool.forKey(key));
    return _applyPlaceholders(rawMessage, playerName: playerName, number: number);
  }

  String _applyPlaceholders(String message, {String? playerName, String? number}) {
    print('RAW MESSAGE: "$message"');
    print('PLAYER NAME: "$playerName"');
    print('NUMBER: "$number"');

    final name = (playerName == null) || playerName.trim().isEmpty ? 'Player' : playerName.trim();
    String newMessage = message.replaceAll('{name}', name);
    if (number != null) newMessage = newMessage.replaceAll('{number}', number);

    print('FINAL MESSAGE: "$newMessage"');
    return newMessage;
  }
}
