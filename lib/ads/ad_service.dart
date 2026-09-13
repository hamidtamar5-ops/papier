import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_config.dart';

/// Publicités AdMob : consentement UMP (RGPD), bannière, interstitiel cadencé.
class AdService {
  DateTime? _startedAt;
  DateTime? _lastInterstitialAt;
  int _interstitialsShown = 0;
  bool _started = false;
  bool _canRequestAds = false;
  bool _showingInterstitial = false;
  InterstitialAd? _interstitial;

  bool get canRequestAds => _canRequestAds;

  bool get _supportedPlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  Future<void> start() async {
    if (_started || !_supportedPlatform) return;
    _started = true;
    _startedAt = DateTime.now();

    await _requestConsent();
    _canRequestAds = await ConsentInformation.instance.canRequestAds();
    if (!_canRequestAds) return;

    await MobileAds.instance.initialize();
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        maxAdContentRating: MaxAdContentRating.pg,
        ageRestrictedTreatment: AgeRestrictedTreatment.unspecified,
      ),
    );
    await preloadInterstitial();
  }

  Future<void> _requestConsent() async {
    final completer = Completer<void>();
    final params = ConsentRequestParameters(
      tagForUnderAgeOfConsent: false,
    );
    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        await ConsentForm.loadAndShowConsentFormIfRequired((_) {});
        if (!completer.isCompleted) completer.complete();
      },
      (_) {
        if (!completer.isCompleted) completer.complete();
      },
    );
    await completer.future.timeout(
      const Duration(seconds: 12),
      onTimeout: () {},
    );
  }

  Future<void> showPrivacyOptions() async {
    if (!_supportedPlatform) return;
    final completer = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((_) {
      if (!completer.isCompleted) completer.complete();
    });
    await completer.future.timeout(
      const Duration(seconds: 12),
      onTimeout: () {},
    );
    _canRequestAds = await ConsentInformation.instance.canRequestAds();
    if (_canRequestAds) {
      await MobileAds.instance.initialize();
      await preloadInterstitial();
    } else {
      _interstitial?.dispose();
      _interstitial = null;
    }
  }

  Future<void> preloadInterstitial() async {
    if (!_canRequestAds || !_supportedPlatform) return;
    if (_interstitial != null) return;
    await InterstitialAd.load(
      adUnitId: AdConfig.interstitialUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitial = ad;
          ad.setImmersiveMode(true);
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitial = null;
              _showingInterstitial = false;
              preloadInterstitial();
            },
            onAdFailedToShowFullScreenContent: (ad, _) {
              ad.dispose();
              _interstitial = null;
              _showingInterstitial = false;
              preloadInterstitial();
            },
          );
        },
        onAdFailedToLoad: (_) {
          _interstitial = null;
        },
      ),
    );
  }

  /// Interstitiel uniquement après une action utile (ex. enregistrement),
  /// jamais au lancement, jamais sur retour arrière, jamais à chaque geste.
  Future<void> showInterstitialAfterAction() async {
    if (!_canRequestAds || _showingInterstitial) return;
    final started = _startedAt;
    if (started == null) return;
    if (DateTime.now().difference(started) <
        AdConfig.minUptimeBeforeInterstitial) {
      return;
    }
    if (_interstitialsShown >= AdConfig.maxInterstitialsPerSession) return;
    final last = _lastInterstitialAt;
    if (last != null &&
        DateTime.now().difference(last) < AdConfig.interstitialCooldown) {
      return;
    }
    final ad = _interstitial;
    if (ad == null) {
      await preloadInterstitial();
      return;
    }
    _showingInterstitial = true;
    _lastInterstitialAt = DateTime.now();
    _interstitialsShown += 1;
    await ad.show();
  }

  void dispose() {
    _interstitial?.dispose();
    _interstitial = null;
  }
}
