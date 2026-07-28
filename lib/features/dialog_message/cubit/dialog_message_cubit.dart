import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/dialog_message/domain/entities/dialog_message_event.dart';

part 'dialog_message_state.dart';

class DialogMessageCubit extends Cubit<DialogMessageState> {
  int _dialogMessageCounter = 0;

  DialogMessageEvent _nextDialogMessage({required String message, String? upperMessage}) {
    return DialogMessageEvent(message: message, id: _dialogMessageCounter++, upperMessage: upperMessage);
  }

  DialogMessageCubit() : super(DialogMessageState());

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
