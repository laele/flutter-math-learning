part of 'player_profile_cubit.dart';

class PlayerProfileState extends Equatable {
  final PlayerProfileStatus status;
  final PlayerProfileEntity profile;
  final NewRecordEvent? newRecordEvent;

  const PlayerProfileState({
    this.status = PlayerProfileStatus.initial,
    this.profile = const PlayerProfileEntity(),
    this.newRecordEvent,
  });

  PlayerProfileState copyWith({
    PlayerProfileStatus? status,
    PlayerProfileEntity? profile,
    NewRecordEvent? newRecordEvent,
  }) {
    return PlayerProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      newRecordEvent: newRecordEvent ?? this.newRecordEvent,
    );
  }

  @override
  List<Object?> get props => [status, profile, newRecordEvent];
}
