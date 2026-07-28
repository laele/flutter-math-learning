import 'package:equatable/equatable.dart';

class DialogMessageEvent extends Equatable {
  final String message;
  final String? upperMessage;
  final int id;

  const DialogMessageEvent({required this.message, this.upperMessage, required this.id});

  @override
  List<Object?> get props => [message, id, upperMessage];
}
