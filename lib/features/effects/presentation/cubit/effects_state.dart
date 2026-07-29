part of 'effects_cubit.dart';

class EffectsState extends Equatable {
  final EffectsEvent? effectsEvent;

  const EffectsState({this.effectsEvent});

  EffectsState copyWith({
    EffectsEvent? effectsEvent,
  }) {
    return EffectsState(
      effectsEvent: effectsEvent ?? this.effectsEvent,
    );
  }

  @override
  List<Object?> get props => [effectsEvent];
}
