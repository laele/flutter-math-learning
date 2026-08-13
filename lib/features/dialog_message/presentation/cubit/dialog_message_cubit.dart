import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/mixins/event_emitter.dart';
import 'package:flutter_math_app/features/dialog_message/domain/entities/dialog_message_event.dart';
import 'package:flutter_math_app/features/dialog_message/domain/enums/message_key_type.dart';
import 'package:flutter_math_app/features/dialog_message/domain/repositories/dialog_message_repository.dart';

part 'dialog_message_state.dart';

class DialogMessageCubit extends Cubit<DialogMessageState> with EventEmitter {
  final DialogMessageRepository _repository;

  DialogMessageEvent _nextDialogMessage({required String message, String? upperMessage}) {
    return DialogMessageEvent(message: message, id: nextEventId(), upperMessage: upperMessage);
  }

  DialogMessageCubit({required DialogMessageRepository repository})
    : _repository = repository,
      super(
        DialogMessageState(),
      );

  void showMessageByKey({required MessageKeyType key, String? upperMessage, required String playerName}) {
    final message = _repository.getMessage(key: key, playerName: playerName);
    emit(
      state.copyWith(
        dialogMessageEvent: _nextDialogMessage(
          message: message,
          upperMessage: upperMessage,
        ),
      ),
    );
  }

  void showMessage({required String message, String? upperMessage}) {
    emit(
      state.copyWith(
        dialogMessageEvent: _nextDialogMessage(
          message: message,
          upperMessage: upperMessage,
        ),
      ),
    );
  }
}
