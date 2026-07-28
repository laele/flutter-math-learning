import 'package:equatable/equatable.dart';

class GameDialogMessageEvent extends Equatable {
  final String message;
  final String? upperMessage;
  final int id;

  const GameDialogMessageEvent({required this.id, required this.message, this.upperMessage});

  @override
  List<Object?> get props => [
    message,
    id,
    upperMessage,
  ];
}
