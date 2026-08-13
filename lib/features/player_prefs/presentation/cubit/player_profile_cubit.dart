import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/mixins/event_emitter.dart';
import 'package:flutter_math_app/features/player_prefs/domain/entities/new_record_event.dart';
import 'package:flutter_math_app/features/player_prefs/domain/entities/player_profile_entity.dart';
import 'package:flutter_math_app/features/player_prefs/domain/enums/player_profile_status.dart';
import 'package:flutter_math_app/features/player_prefs/domain/repositories/player_profile_repository.dart';

part 'player_profile_state.dart';

class PlayerProfileCubit extends Cubit<PlayerProfileState> with EventEmitter {
  final PlayerProfileRepository _repository;

  PlayerProfileCubit({required PlayerProfileRepository repository})
    : _repository = repository,
      super(
        PlayerProfileState(),
      );

  NewRecordEvent _nextRecordEvent({required int newScore}) {
    return NewRecordEvent(id: nextEventId(), score: newScore);
  }

  Future<void> loadProfile() async {
    emit(state.copyWith(status: PlayerProfileStatus.loading));
    final result = await _repository.getPlayerProfile();
    result.fold(
      (failure) => emit(state.copyWith(status: PlayerProfileStatus.error)),
      (profile) {
        print(profile);
        emit(state.copyWith(status: PlayerProfileStatus.success, profile: profile));
      },
    );
  }

  Future<void> registerFinalScore({required int score}) async {
    emit(state.copyWith(status: PlayerProfileStatus.loading));
    final result = await _repository.saveBestScore(score: score);
    result.fold(
      (failure) => emit(state.copyWith(status: PlayerProfileStatus.error)),
      (profile) {
        final isNewScore = profile.bestArcadeScore == score && score > state.profile.bestArcadeScore;
        if (isNewScore) {
          emit(
            state.copyWith(
              status: PlayerProfileStatus.success,
              profile: profile,
              newRecordEvent: _nextRecordEvent(newScore: score),
            ),
          );
        }
      },
    );
  }

  Future<void> updateName({required String name}) async {
    emit(state.copyWith(status: PlayerProfileStatus.loading));
    final result = await _repository.updatePlayerName(name: name);
    result.fold(
      (failure) => emit(state.copyWith(status: PlayerProfileStatus.error)),
      (profile) {
        emit(
          state.copyWith(
            status: PlayerProfileStatus.success,
            profile: profile,
          ),
        );
      },
    );
  }
}
