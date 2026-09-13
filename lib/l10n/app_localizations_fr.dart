// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Échéances';

  @override
  String get settings => 'Réglages';

  @override
  String get addDocument => 'Ajouter un papier';

  @override
  String errorWithMessage(String error) {
    return 'Erreur : $error';
  }

  @override
  String get noDocsForPerson => 'Aucun papier pour ce titulaire.';

  @override
  String get sectionRenew => 'À renouveler';

  @override
  String get sectionWatch => 'À surveiller';

  @override
  String get sectionOk => 'À jour';

  @override
  String get deleteConfirmTitle => 'Supprimer ?';

  @override
  String deleteDocumentBody(String label) {
    return 'Retirer « $label » de la liste.';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get nextDeadline => 'Prochaine échéance';

  @override
  String get filterAll => 'Tous';

  @override
  String get emptyTitle => 'Aucun papier pour l’instant';

  @override
  String get emptySubtitle =>
      'Ajoutez une date (CNI, passeport, CT, assurance…). Aucune photo n’est demandée.';

  @override
  String get statusOk => 'OK';

  @override
  String get statusSoon => 'Bientôt';

  @override
  String get statusOverdue => 'Dépassé';

  @override
  String get expiredYesterday => 'expiré hier';

  @override
  String expiredDays(int count) {
    return 'expiré depuis $count jours';
  }

  @override
  String get expiresToday => 'expire aujourd’hui';

  @override
  String get inOneDay => 'dans 1 jour';

  @override
  String inDays(int count) {
    return 'dans $count jours';
  }

  @override
  String get digestTitleRenew => 'Papiers à renouveler';

  @override
  String get digestTitleToday => 'Échéance aujourd’hui';

  @override
  String get digestTitleSoon => 'Échéance proche';

  @override
  String digestBodyOneOverdue(String label) {
    return '$label est dépassé.';
  }

  @override
  String digestBodyOneToday(String label) {
    return '$label expire aujourd’hui.';
  }

  @override
  String digestBodyOneSoon(String label) {
    return '$label expire dans moins de 7 jours.';
  }

  @override
  String get digestPartOneOverdue => '1 papier dépassé';

  @override
  String digestPartManyOverdue(int count) {
    return '$count papiers dépassés';
  }

  @override
  String get digestPartOneToday => '1 aujourd’hui';

  @override
  String digestPartManyToday(int count) {
    return '$count aujourd’hui';
  }

  @override
  String get digestPartOneSoon => '1 dans moins de 7 jours';

  @override
  String digestPartManySoon(int count) {
    return '$count dans moins de 7 jours';
  }

  @override
  String get aDocument => 'Un papier';

  @override
  String get addPaper => 'Ajouter un papier';

  @override
  String get edit => 'Modifier';

  @override
  String get documentType => 'Type de document';

  @override
  String get details => 'Détails';

  @override
  String get labelField => 'Libellé';

  @override
  String get holder => 'Titulaire';

  @override
  String get computeFromStart => 'Calculer depuis une date de départ';

  @override
  String get startDate => 'Date de départ';

  @override
  String get expirationDate => 'Date d’expiration';

  @override
  String get choose => 'Choisir';

  @override
  String get alertsAndReminders => 'Alertes et rappels';

  @override
  String get reminderHint =>
      'Notification le matin à 9 h, plus une alerte le jour J.';

  @override
  String get notes => 'Notes';

  @override
  String get notesHint => 'Notes (optionnel, pas de numéro de pièce)';

  @override
  String get save => 'Enregistrer';

  @override
  String get chooseHolderAndDate => 'Choisissez un titulaire et une date.';

  @override
  String get kindCni => 'Carte d’identité';

  @override
  String get kindPasseport => 'Passeport';

  @override
  String get kindPermis => 'Permis de conduire';

  @override
  String get kindCarteVitale => 'Carte vitale';

  @override
  String get kindCarteGrise => 'Carte grise';

  @override
  String get kindControleTechnique => 'Contrôle technique';

  @override
  String get kindAssuranceAuto => 'Assurance auto';

  @override
  String get kindPersonnalise => 'Autre papier';

  @override
  String get hintCni =>
      'Saisissez la date d’expiration écrite sur la carte. Durée habituelle : 10 ans après délivrance — vérifiez toujours la carte.';

  @override
  String get hintPasseport =>
      'Date d’expiration sur le passeport. Souvent 10 ans (majeur) ou 5 ans (mineur).';

  @override
  String get hintPermis =>
      'Saisissez la date figurant sur le titre. Aucune durée n’est inventée.';

  @override
  String get hintCarteVitale =>
      'Saisissez la date que vous souhaitez surveiller, si elle est connue.';

  @override
  String get hintCarteGrise =>
      'Saisissez la date à surveiller (pas un scan du certificat).';

  @override
  String get hintControleTechnique =>
      'Date de validité, ou calcul depuis le dernier contrôle (+2 ans, ou +4 ans si véhicule neuf).';

  @override
  String get hintAssuranceAuto =>
      'Date d’échéance, ou + 1 an depuis le début du contrat.';

  @override
  String get hintPersonnalise =>
      'Libellé libre et date. Pas de photo, pas de numéro de pièce.';

  @override
  String get offset2Years => '+ 2 ans (déjà en circulation)';

  @override
  String get offset4Years => '+ 4 ans (véhicule neuf)';

  @override
  String get offset1Year => '+ 1 an';

  @override
  String get appearance => 'Apparence';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get language => 'Langue';

  @override
  String get languageSystem => 'Langue du téléphone';

  @override
  String get languageFr => 'Français';

  @override
  String get languageEn => 'English';

  @override
  String get languageEs => 'Español';

  @override
  String get languageDe => 'Deutsch';

  @override
  String get languageAr => 'العربية';

  @override
  String get alertsAndNotifications => 'Alertes et notifications';

  @override
  String get householdHolders => 'Titulaires du foyer';

  @override
  String get addHolder => 'Ajouter un titulaire';

  @override
  String get iapNote =>
      'Foyer illimité et export PDF sont prévus en achat unique. En v1, tout est ouvert.';

  @override
  String get backup => 'Sauvegarde';

  @override
  String get exportJson => 'Exporter JSON';

  @override
  String get exportJsonSubtitle => 'Fichier local, sans photos.';

  @override
  String get importJson => 'Importer JSON';

  @override
  String get importDone => 'Import terminé.';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get privacyText =>
      'Les dates restent sur cet appareil. Pas de compte, pas d’analytics, pas de photo de pièce d’identité. Cette app n’est pas un service administratif. Des publicités Google AdMob peuvent s’afficher ; dans l’Espace économique européen, votre consentement est demandé.';

  @override
  String get privacyAdsTitle => 'Publicité';

  @override
  String get privacyAdsBody =>
      'Une bannière peut apparaître en bas de l’accueil. Un interstitiel n’est proposé qu’après un enregistrement, jamais au lancement ni en quittant l’app.';

  @override
  String get manageAdsConsent => 'Gérer le consentement publicitaire';

  @override
  String get deleteHolderTitle => 'Supprimer ce titulaire ?';

  @override
  String deleteHolderBody(String name) {
    return '« $name » et ses papiers seront retirés.';
  }

  @override
  String get newHolder => 'Nouveau titulaire';

  @override
  String get firstName => 'Prénom';

  @override
  String get ok => 'OK';

  @override
  String get deviceAlerts => 'Alertes de l’appareil';

  @override
  String get deviceAlertsSubtitle =>
      'Rappels le matin à 9 h et alerte le jour J.';

  @override
  String get notifsDisabled =>
      'Les notifications sont désactivées pour cette application.';

  @override
  String get allowAlerts => 'Autoriser les alertes';

  @override
  String get defaultReminders => 'Rappels par défaut';

  @override
  String get testNotifSent => 'Notification de test envoyée.';

  @override
  String get sendTestNotif => 'Envoyer une notification test';

  @override
  String notifExpiresToday(String date) {
    return 'Expire aujourd’hui ($date).';
  }

  @override
  String notifDueInDays(int days, String date) {
    return 'Échéance dans $days jours ($date).';
  }

  @override
  String get testNotifTitle => 'Alertes Échéances';

  @override
  String get testNotifBody =>
      'Les notifications fonctionnent. Vous serez prévenu avant chaque date.';

  @override
  String get widgetNoDeadline => 'Aucune échéance';

  @override
  String get widgetAddPaper => 'Ajoutez un papier';

  @override
  String get deleteTooltip => 'Supprimer';
}
