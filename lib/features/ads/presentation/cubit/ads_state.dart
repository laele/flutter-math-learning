part of 'ads_cubit.dart';

enum AdsStatus { unavailable, ready }

class AdsState extends Equatable {
  final bool interstitialReady;
  final AdsStatus status;

  const AdsState({
    this.interstitialReady = false,
    this.status = AdsStatus.unavailable,
  });

  AdsState copyWith({
    bool? interstitialReady,
    AdsStatus? status,
  }) {
    return AdsState(
      interstitialReady: interstitialReady ?? this.interstitialReady,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
    interstitialReady,
    status,
  ];
}
