import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/mixins/event_emitter.dart';
import 'package:flutter_math_app/features/character/domain/enums/character_animation_type.dart';
import 'package:flutter_math_app/features/character/domain/entities/character_animation_event.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> with EventEmitter {
  CharacterCubit() : super(CharacterState());

  CharacterAnimationEvent _nextCharacterAnimation(CharacterAnimationType type) {
    return CharacterAnimationEvent(type: type, id: nextEventId());
  }

  void playCharacterAnimation(CharacterAnimationType animation) {
    emit(state.copyWith(animationEvent: _nextCharacterAnimation(animation)));
  }

  void setControllerReady() {
    emit(state.copyWith(controllerReady: true));
  }
}
