import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState(petAnimation: PetAnimation.idle, message: null));

  void playPetSuccess({String? message, int? num}) {
    playAnimation(PetAnimation.success, 'You draw $num number!');
  }

  void playPetThinking({String? message}) {
    playAnimation(PetAnimation.thinking, message);
  }

  void playPetFailed({String? message}) {
    playAnimation(PetAnimation.failed, message);
  }

  void playAnimation(PetAnimation animation, String? message) {
    emit(
      state.copyWith(petAnimation: animation, message: message),
    );
    //emit(state.copyWith(petAnimation: PetAnimation.idle));
  }

  void clearMessage() {
    emit(state.copyWith(petAnimation: PetAnimation.idle, message: null));
  }
}
