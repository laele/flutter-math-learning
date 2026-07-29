import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/effects/domain/entities/effects_event.dart';
import 'package:flutter_math_app/features/effects/domain/enums/effect_type.dart';

part 'effects_state.dart';

class EffectsCubit extends Cubit<EffectsState> {
  int _effectsEventCounter = 0;
  EffectsCubit() : super(EffectsState());

  void _emitNewEffectsEvent({required EffectsType effectsType}) {
    final EffectsEvent effectsEvent = EffectsEvent(type: effectsType, id: ++_effectsEventCounter);
    emit(state.copyWith(effectsEvent: effectsEvent));
  }

  void playEffect({required EffectsType effect}) {
    _emitNewEffectsEvent(effectsType: effect);
  }
}
