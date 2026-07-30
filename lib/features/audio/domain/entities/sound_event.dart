import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/audio/domain/enums/sound_type.dart';

class SoundEvent extends Equatable {
  final SoundType type;
  final int id;

  const SoundEvent({required this.type, required this.id});

  @override
  List<Object?> get props => [type, id];
}
