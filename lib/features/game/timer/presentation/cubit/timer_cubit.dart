import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  Timer? _timer;
  DateTime? _startedAt;

  Duration _totalDuration = Duration.zero;
  TimerCubit()
    : super(
        TimerState(
          totalTime: Duration.zero,
          remainingTime: Duration.zero,
        ),
      );

  void startTimer({required Duration duration}) {
    _timer?.cancel();

    _startedAt = DateTime.now();

    _totalDuration = duration;

    emit(state.copyWith(remainingTime: duration, totalTime: duration, isRunning: true));

    _timer = Timer.periodic(
      const Duration(milliseconds: 16),
      (timer) {
        if (isClosed) return;

        final elapsed = DateTime.now().difference(_startedAt!);

        var remaining = _totalDuration - elapsed;

        if (remaining.isNegative) {
          remaining = Duration.zero;
        }

        final completed = remaining == Duration.zero;

        emit(state.copyWith(remainingTime: remaining, isRunning: !completed));

        if (completed) {
          _timer?.cancel();
          _timer = null;
        }
      },
    );
  }

  void pauseTimer() {
    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
