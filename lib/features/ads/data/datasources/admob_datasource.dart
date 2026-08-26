import 'dart:async';

import 'package:flutter_math_app/core/constants/ad_unit_ids.dart';
import 'package:flutter_math_app/core/error/exceptions.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobDataSource {
  InterstitialAd? _interstitialAd;

  Future<void> initialize() async {
    final requestConfiguration = RequestConfiguration(
      ageRestrictedTreatment: AgeRestrictedTreatment.child,
      maxAdContentRating: MaxAdContentRating.g,
      testDeviceIds: [
        '581202C278272890FB42E56420EFEE4B', // SAMSUNG TABLET
      ],
    );
    await MobileAds.instance.updateRequestConfiguration(requestConfiguration);
    await MobileAds.instance.initialize();
  }

  Future<void> loadInterstitial() async {
    final completer = Completer<void>();

    await InterstitialAd.load(
      adUnitId: AdUnitIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          completer.complete();
        },
        onAdFailedToLoad: (error) {
          completer.completeError(AdLoadException(message: error.message));
        },
      ),
    );
    return completer.future;
  }

  Future<bool> showInterstitialIfReady() async {
    if (_interstitialAd == null) return false;

    final completer = Completer<bool>();
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        completer.complete(true);
      },
      onAdShowedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        completer.complete(false);
      },
    );
    await _interstitialAd!.show();
    return completer.future;
  }
}
