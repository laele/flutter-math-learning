// presentation/widgets/banner_ad_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/constants/ad_unit_ids.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  /* @override
  void initState() {
    super.initState();
    _loadBanner();
  }*/

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _loadBanner();
  }

  void _loadBanner() async {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;

    AdSize adSize;

    if (screenHeight >= 950) {
      final int widthInDp = mediaQuery.size.width.truncate();
      final AnchoredAdaptiveBannerAdSize? adaptiveSize = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(widthInDp);

      adSize = adaptiveSize ?? AdSize.banner;
    } else {
      adSize = AdSize.banner;
    }

    _bannerAd = BannerAd(
      adUnitId: AdUnitIds.banner,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (!mounted) return;
          setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          print(error.message);
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) return const SizedBox.shrink();
    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
