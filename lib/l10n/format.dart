import 'package:flutter/widgets.dart';

import '../domain/echeance.dart';
import '../domain/models.dart';
import 'app_localizations.dart';

const supportedLanguageCodes = ['fr', 'en', 'es', 'de', 'ar'];

Locale localeFromSettings(AppSettings settings) {
  if (settings.language != AppLanguage.system) {
    return Locale(settings.language.name);
  }
  final device = WidgetsBinding.instance.platformDispatcher.locale;
  if (supportedLanguageCodes.contains(device.languageCode)) {
    return Locale(device.languageCode);
  }
  return const Locale('fr');
}

String languageLabel(AppLocalizations l10n, AppLanguage language) {
  return switch (language) {
    AppLanguage.system => l10n.languageSystem,
    AppLanguage.fr => l10n.languageFr,
    AppLanguage.en => l10n.languageEn,
    AppLanguage.es => l10n.languageEs,
    AppLanguage.de => l10n.languageDe,
    AppLanguage.ar => l10n.languageAr,
  };
}

String localizedStatus(AppLocalizations l10n, EcheanceStatus status) {
  return switch (status) {
    EcheanceStatus.ok => l10n.statusOk,
    EcheanceStatus.bientot => l10n.statusSoon,
    EcheanceStatus.depasse => l10n.statusOverdue,
  };
}

String localizedDaysLabel(AppLocalizations l10n, int days) {
  if (days < 0) {
    final n = -days;
    return n == 1 ? l10n.expiredYesterday : l10n.expiredDays(n);
  }
  if (days == 0) return l10n.expiresToday;
  if (days == 1) return l10n.inOneDay;
  return l10n.inDays(days);
}

String localizedDigestTitle(AppLocalizations l10n, AlertDigest digest) {
  if (digest.expiredCount > 0) return l10n.digestTitleRenew;
  if (digest.todayCount > 0) return l10n.digestTitleToday;
  return l10n.digestTitleSoon;
}

String localizedDigestBody(AppLocalizations l10n, AlertDigest digest) {
  final sample = digest.sampleLabel ?? l10n.aDocument;
  if (digest.expiredCount == 1 &&
      digest.todayCount == 0 &&
      digest.soonCount == 0) {
    return l10n.digestBodyOneOverdue(sample);
  }
  if (digest.todayCount == 1 &&
      digest.expiredCount == 0 &&
      digest.soonCount == 0) {
    return l10n.digestBodyOneToday(sample);
  }
  if (digest.soonCount == 1 &&
      digest.expiredCount == 0 &&
      digest.todayCount == 0) {
    return l10n.digestBodyOneSoon(sample);
  }
  final parts = <String>[];
  if (digest.expiredCount > 0) {
    parts.add(
      digest.expiredCount == 1
          ? l10n.digestPartOneOverdue
          : l10n.digestPartManyOverdue(digest.expiredCount),
    );
  }
  if (digest.todayCount > 0) {
    parts.add(
      digest.todayCount == 1
          ? l10n.digestPartOneToday
          : l10n.digestPartManyToday(digest.todayCount),
    );
  }
  if (digest.soonCount > 0) {
    parts.add(
      digest.soonCount == 1
          ? l10n.digestPartOneSoon
          : l10n.digestPartManySoon(digest.soonCount),
    );
  }
  return '${parts.join(' · ')}.';
}

String localizedKind(AppLocalizations l10n, DocumentKind kind) {
  return switch (kind) {
    DocumentKind.cni => l10n.kindCni,
    DocumentKind.passeport => l10n.kindPasseport,
    DocumentKind.permis => l10n.kindPermis,
    DocumentKind.carteVitale => l10n.kindCarteVitale,
    DocumentKind.carteGrise => l10n.kindCarteGrise,
    DocumentKind.controleTechnique => l10n.kindControleTechnique,
    DocumentKind.assuranceAuto => l10n.kindAssuranceAuto,
    DocumentKind.personnalise => l10n.kindPersonnalise,
  };
}

String localizedHint(AppLocalizations l10n, DocumentKind kind) {
  return switch (kind) {
    DocumentKind.cni => l10n.hintCni,
    DocumentKind.passeport => l10n.hintPasseport,
    DocumentKind.permis => l10n.hintPermis,
    DocumentKind.carteVitale => l10n.hintCarteVitale,
    DocumentKind.carteGrise => l10n.hintCarteGrise,
    DocumentKind.controleTechnique => l10n.hintControleTechnique,
    DocumentKind.assuranceAuto => l10n.hintAssuranceAuto,
    DocumentKind.personnalise => l10n.hintPersonnalise,
  };
}

String localizedOffset(AppLocalizations l10n, int years) {
  return switch (years) {
    1 => l10n.offset1Year,
    2 => l10n.offset2Years,
    4 => l10n.offset4Years,
    _ => '+ $years',
  };
}
