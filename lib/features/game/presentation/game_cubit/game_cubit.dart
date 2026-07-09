import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
    : super(
        GameState(
          petAnimation: PetAnimation.idle,
          message: null,
          gameMode: GameMode.learnNumbers,
        ),
      );

  void generateNextLevel() {
    // Check gameMode
    final previousNum = state.result;
    int nextNum;
    do {
      nextNum = Random().nextInt(10);
      if (state.result == null) break;
    } while (nextNum == previousNum);
    emit(state.copyWith(result: nextNum));
  }

  void checkResult(int result) {
    if (result == state.result) {
      generateNextLevel();
      playAnimation(PetAnimation.success, 'Amazing, Let\'s try next number!');
    } else {
      playAnimation(PetAnimation.failed, 'Nope, Try it again!');
    }
  }

  void playPetSuccess({String? message, int? num}) {
    playAnimation(PetAnimation.success, 'It looks like a $num!');
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
  }

  void clearMessage() {
    emit(state.copyWith(petAnimation: PetAnimation.idle, message: null));
  }
}
