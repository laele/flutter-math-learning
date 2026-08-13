import 'package:equatable/equatable.dart';

abstract class DomainEvent extends Equatable {
  final int id;
  const DomainEvent({required int this.id});

  @override
  List<Object?> get props => [id];
}
