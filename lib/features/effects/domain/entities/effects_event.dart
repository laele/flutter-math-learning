import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/effects/domain/enums/effect_type.dart';

class EffectsEvent extends Equatable {
  final EffectsType type;
  final int id;

  const EffectsEvent({required this.type, required this.id});

  @override
  List<Object?> get props => [type, id];
}
