import 'package:equatable/equatable.dart';

class NewRecordEvent extends Equatable {
  final int id;
  final int score;

  const NewRecordEvent({required this.id, required this.score});

  @override
  List<Object?> get props => [id, score];
}
