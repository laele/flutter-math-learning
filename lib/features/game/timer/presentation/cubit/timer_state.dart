part of 'timer_cubit.dart';

class TimerState extends Equatable {
  final Duration remainingTime;
  final Duration totalTime;
  final bool isRunning;

  const TimerState({
    required this.remainingTime,
    required this.totalTime,
    this.isRunning = false,
  });

  bool get isCompleted => remainingTime <= Duration.zero;
  double get progress => totalTime == Duration.zero ? 0 : remainingTime.inMilliseconds / totalTime.inMilliseconds;

  TimerState copyWith({
    Duration? remainingTime,
    Duration? totalTime,
    bool? isRunning,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      totalTime: totalTime ?? this.totalTime,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }

  @override
  List<Object?> get props => [remainingTime, totalTime, isRunning];
}
