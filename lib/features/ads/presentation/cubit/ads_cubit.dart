import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/ads/domain/repositories/ads_repository.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  final AdsRepository _repository;
  int _sessionsSinceLastAd = 0;
  static const int _sessionPerAd = 8;

  AdsCubit({required AdsRepository repository}) : _repository = repository, super(AdsState());

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
    final result = await _repository.loadInterstitial();
    result.fold(
      (l) => emit(state.copyWith(interstitialReady: false)),
      (r) => emit(state.copyWith(interstitialReady: true)),
    );
  }

  Future<void> showInterstitialAtNaturalBreak() async {
    _sessionsSinceLastAd++;
    if (_sessionsSinceLastAd < _sessionPerAd) return;
    if (!state.interstitialReady) return;
    final result = await _repository.showInterstitialIfReady();
    result.fold(
      (l) {},
      (shown) {
        emit(state.copyWith(interstitialReady: false));
        if (shown) preloadIntersticial();
      },
    );
  }
}
