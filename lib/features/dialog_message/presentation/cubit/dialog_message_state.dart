part of 'dialog_message_cubit.dart';

class DialogMessageState extends Equatable {
  final DialogMessageEvent? dialogMessageEvent;

  const DialogMessageState({this.dialogMessageEvent});

  DialogMessageState copyWith({
    DialogMessageEvent? dialogMessageEvent,
  }) {
    return DialogMessageState(
      dialogMessageEvent: dialogMessageEvent ?? this.dialogMessageEvent,
    );
  }

  @override
  List<Object?> get props => [
    dialogMessageEvent,
  ];
}
