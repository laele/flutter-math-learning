import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/ads/domain/repositories/ads_repository.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  final AdsRepository _repository;
  static const int _sessionPerAd = 5;
  static const Duration _minTimeinterval = Duration(minutes: 3);

  AdsCubit({required AdsRepository repository})
    : _repository = repository,
      super(AdsState());

  Future<void> initialize() async {
    final result = await _repository.initialize();
    result.fold(
      (l) => emit(state.copyWith(status: AdsStatus.unavailable)),
      (r) {
        emit(state.copyWith(status: AdsStatus.ready));
        preloadIntersticial();
      },
    );
  }

  void preloadIntersticial() async {
    if (state.interstitialReady) return;
    final result = await _repository.loadInterstitial();
    result.fold(
      (l) => emit(state.copyWith(interstitialReady: false)),
      (r) => emit(state.copyWith(interstitialReady: true)),
    );
  }

  Future<void> showInterstitialAtNaturalBreak() async {
    await _repository.recordSessionCompleted();

    final sessionsCounterResult = await _repository.getSessionsSinceLastAd();
    final lastSessionShownResult = await _repository.getLastShownAt();

    final sessionsCounter = sessionsCounterResult.getOrElse(() => 0);
    final lastSessionShown = lastSessionShownResult.getOrElse(() => null);

    final showAdSession = sessionsCounter >= _sessionPerAd;
    final showAdTimePassed =
        lastSessionShown == null ||
        DateTime.now().difference(lastSessionShown) >= _minTimeinterval;

    if (!showAdSession || !showAdTimePassed) return;
    if (!state.interstitialReady) {
      preloadIntersticial();
      return;
    }

    final shownResult = await _repository.showInterstitialIfReady();
    shownResult.fold(
      (l) {},
      (shown) async {
        emit(state.copyWith(interstitialReady: false));
        await _repository.recordAdShown();
        preloadIntersticial();
      },
    );
  }
}
