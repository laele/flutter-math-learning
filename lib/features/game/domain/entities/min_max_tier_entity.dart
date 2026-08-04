import 'package:equatable/equatable.dart';

class MinMaxTierEntity extends Equatable {
  final int min;
  final int max;
  final double weight;

  const MinMaxTierEntity({required this.min, required this.max, required this.weight});

  @override
  List<Object?> get props => [min, max, weight];
}
