/// Identifiants AdMob.
///
/// Avant publication Play : passez [useTestAds] à false et remplacez
/// [androidAppId], [bannerUnitId] et [interstitialUnitId] par vos IDs
/// (AdMob > Applications > Blocs d'annonces).
/// L’ID d’application du manifeste Android doit être le même que [androidAppId].
class AdConfig {
  const AdConfig._();

  /// true = blocs de test Google (obligatoire tant que l’app n’est pas validée).
  static const useTestAds = true;

  static const _testAppId = 'ca-app-pub-3940256099942544~3347511713';
  static const _testBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _testInterstitial = 'ca-app-pub-3940256099942544/1033173712';

  /// À remplacer par ca-app-pub-xxxxxxxxxxxxxxxx~xxxxxxxxxx
  static const androidAppId = _testAppId;

  static const _prodBanner = 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx';
  static const _prodInterstitial = 'ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx';

  static String get bannerUnitId => useTestAds ? _testBanner : _prodBanner;
  static String get interstitialUnitId =>
      useTestAds ? _testInterstitial : _prodInterstitial;

  /// Pause minimale entre deux interstitiels (politique : pas à chaque geste).
  static const interstitialCooldown = Duration(minutes: 3);

  /// Délai après lancement : jamais d’interstitiel au démarrage.
  static const minUptimeBeforeInterstitial = Duration(seconds: 45);

  /// Plafond par session pour éviter le spam.
  static const maxInterstitialsPerSession = 2;
}
