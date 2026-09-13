import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'Échéances'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In fr, this message translates to:
  /// **'Réglages'**
  String get settings;

  /// No description provided for @addDocument.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un papier'**
  String get addDocument;

  /// No description provided for @errorWithMessage.
  ///
  /// In fr, this message translates to:
  /// **'Erreur : {error}'**
  String errorWithMessage(String error);

  /// No description provided for @noDocsForPerson.
  ///
  /// In fr, this message translates to:
  /// **'Aucun papier pour ce titulaire.'**
  String get noDocsForPerson;

  /// No description provided for @sectionRenew.
  ///
  /// In fr, this message translates to:
  /// **'À renouveler'**
  String get sectionRenew;

  /// No description provided for @sectionWatch.
  ///
  /// In fr, this message translates to:
  /// **'À surveiller'**
  String get sectionWatch;

  /// No description provided for @sectionOk.
  ///
  /// In fr, this message translates to:
  /// **'À jour'**
  String get sectionOk;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer ?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteDocumentBody.
  ///
  /// In fr, this message translates to:
  /// **'Retirer « {label} » de la liste.'**
  String deleteDocumentBody(String label);

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @nextDeadline.
  ///
  /// In fr, this message translates to:
  /// **'Prochaine échéance'**
  String get nextDeadline;

  /// No description provided for @filterAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get filterAll;

  /// No description provided for @emptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun papier pour l’instant'**
  String get emptyTitle;

  /// No description provided for @emptySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez une date (CNI, passeport, CT, assurance…). Aucune photo n’est demandée.'**
  String get emptySubtitle;

  /// No description provided for @statusOk.
  ///
  /// In fr, this message translates to:
  /// **'OK'**
  String get statusOk;

  /// No description provided for @statusSoon.
  ///
  /// In fr, this message translates to:
  /// **'Bientôt'**
  String get statusSoon;

  /// No description provided for @statusOverdue.
  ///
  /// In fr, this message translates to:
  /// **'Dépassé'**
  String get statusOverdue;

  /// No description provided for @expiredYesterday.
  ///
  /// In fr, this message translates to:
  /// **'expiré hier'**
  String get expiredYesterday;

  /// No description provided for @expiredDays.
  ///
  /// In fr, this message translates to:
  /// **'expiré depuis {count} jours'**
  String expiredDays(int count);

  /// No description provided for @expiresToday.
  ///
  /// In fr, this message translates to:
  /// **'expire aujourd’hui'**
  String get expiresToday;

  /// No description provided for @inOneDay.
  ///
  /// In fr, this message translates to:
  /// **'dans 1 jour'**
  String get inOneDay;

  /// No description provided for @inDays.
  ///
  /// In fr, this message translates to:
  /// **'dans {count} jours'**
  String inDays(int count);

  /// No description provided for @digestTitleRenew.
  ///
  /// In fr, this message translates to:
  /// **'Papiers à renouveler'**
  String get digestTitleRenew;

  /// No description provided for @digestTitleToday.
  ///
  /// In fr, this message translates to:
  /// **'Échéance aujourd’hui'**
  String get digestTitleToday;

  /// No description provided for @digestTitleSoon.
  ///
  /// In fr, this message translates to:
  /// **'Échéance proche'**
  String get digestTitleSoon;

  /// No description provided for @digestBodyOneOverdue.
  ///
  /// In fr, this message translates to:
  /// **'{label} est dépassé.'**
  String digestBodyOneOverdue(String label);

  /// No description provided for @digestBodyOneToday.
  ///
  /// In fr, this message translates to:
  /// **'{label} expire aujourd’hui.'**
  String digestBodyOneToday(String label);

  /// No description provided for @digestBodyOneSoon.
  ///
  /// In fr, this message translates to:
  /// **'{label} expire dans moins de 7 jours.'**
  String digestBodyOneSoon(String label);

  /// No description provided for @digestPartOneOverdue.
  ///
  /// In fr, this message translates to:
  /// **'1 papier dépassé'**
  String get digestPartOneOverdue;

  /// No description provided for @digestPartManyOverdue.
  ///
  /// In fr, this message translates to:
  /// **'{count} papiers dépassés'**
  String digestPartManyOverdue(int count);

  /// No description provided for @digestPartOneToday.
  ///
  /// In fr, this message translates to:
  /// **'1 aujourd’hui'**
  String get digestPartOneToday;

  /// No description provided for @digestPartManyToday.
  ///
  /// In fr, this message translates to:
  /// **'{count} aujourd’hui'**
  String digestPartManyToday(int count);

  /// No description provided for @digestPartOneSoon.
  ///
  /// In fr, this message translates to:
  /// **'1 dans moins de 7 jours'**
  String get digestPartOneSoon;

  /// No description provided for @digestPartManySoon.
  ///
  /// In fr, this message translates to:
  /// **'{count} dans moins de 7 jours'**
  String digestPartManySoon(int count);

  /// No description provided for @aDocument.
  ///
  /// In fr, this message translates to:
  /// **'Un papier'**
  String get aDocument;

  /// No description provided for @addPaper.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un papier'**
  String get addPaper;

  /// No description provided for @edit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get edit;

  /// No description provided for @documentType.
  ///
  /// In fr, this message translates to:
  /// **'Type de document'**
  String get documentType;

  /// No description provided for @details.
  ///
  /// In fr, this message translates to:
  /// **'Détails'**
  String get details;

  /// No description provided for @labelField.
  ///
  /// In fr, this message translates to:
  /// **'Libellé'**
  String get labelField;

  /// No description provided for @holder.
  ///
  /// In fr, this message translates to:
  /// **'Titulaire'**
  String get holder;

  /// No description provided for @computeFromStart.
  ///
  /// In fr, this message translates to:
  /// **'Calculer depuis une date de départ'**
  String get computeFromStart;

  /// No description provided for @startDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de départ'**
  String get startDate;

  /// No description provided for @expirationDate.
  ///
  /// In fr, this message translates to:
  /// **'Date d’expiration'**
  String get expirationDate;

  /// No description provided for @choose.
  ///
  /// In fr, this message translates to:
  /// **'Choisir'**
  String get choose;

  /// No description provided for @alertsAndReminders.
  ///
  /// In fr, this message translates to:
  /// **'Alertes et rappels'**
  String get alertsAndReminders;

  /// No description provided for @reminderHint.
  ///
  /// In fr, this message translates to:
  /// **'Notification le matin à 9 h, plus une alerte le jour J.'**
  String get reminderHint;

  /// No description provided for @notes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notesHint.
  ///
  /// In fr, this message translates to:
  /// **'Notes (optionnel, pas de numéro de pièce)'**
  String get notesHint;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @chooseHolderAndDate.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un titulaire et une date.'**
  String get chooseHolderAndDate;

  /// No description provided for @kindCni.
  ///
  /// In fr, this message translates to:
  /// **'Carte d’identité'**
  String get kindCni;

  /// No description provided for @kindPasseport.
  ///
  /// In fr, this message translates to:
  /// **'Passeport'**
  String get kindPasseport;

  /// No description provided for @kindPermis.
  ///
  /// In fr, this message translates to:
  /// **'Permis de conduire'**
  String get kindPermis;

  /// No description provided for @kindCarteVitale.
  ///
  /// In fr, this message translates to:
  /// **'Carte vitale'**
  String get kindCarteVitale;

  /// No description provided for @kindCarteGrise.
  ///
  /// In fr, this message translates to:
  /// **'Carte grise'**
  String get kindCarteGrise;

  /// No description provided for @kindControleTechnique.
  ///
  /// In fr, this message translates to:
  /// **'Contrôle technique'**
  String get kindControleTechnique;

  /// No description provided for @kindAssuranceAuto.
  ///
  /// In fr, this message translates to:
  /// **'Assurance auto'**
  String get kindAssuranceAuto;

  /// No description provided for @kindPersonnalise.
  ///
  /// In fr, this message translates to:
  /// **'Autre papier'**
  String get kindPersonnalise;

  /// No description provided for @hintCni.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez la date d’expiration écrite sur la carte. Durée habituelle : 10 ans après délivrance — vérifiez toujours la carte.'**
  String get hintCni;

  /// No description provided for @hintPasseport.
  ///
  /// In fr, this message translates to:
  /// **'Date d’expiration sur le passeport. Souvent 10 ans (majeur) ou 5 ans (mineur).'**
  String get hintPasseport;

  /// No description provided for @hintPermis.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez la date figurant sur le titre. Aucune durée n’est inventée.'**
  String get hintPermis;

  /// No description provided for @hintCarteVitale.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez la date que vous souhaitez surveiller, si elle est connue.'**
  String get hintCarteVitale;

  /// No description provided for @hintCarteGrise.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez la date à surveiller (pas un scan du certificat).'**
  String get hintCarteGrise;

  /// No description provided for @hintControleTechnique.
  ///
  /// In fr, this message translates to:
  /// **'Date de validité, ou calcul depuis le dernier contrôle (+2 ans, ou +4 ans si véhicule neuf).'**
  String get hintControleTechnique;

  /// No description provided for @hintAssuranceAuto.
  ///
  /// In fr, this message translates to:
  /// **'Date d’échéance, ou + 1 an depuis le début du contrat.'**
  String get hintAssuranceAuto;

  /// No description provided for @hintPersonnalise.
  ///
  /// In fr, this message translates to:
  /// **'Libellé libre et date. Pas de photo, pas de numéro de pièce.'**
  String get hintPersonnalise;

  /// No description provided for @offset2Years.
  ///
  /// In fr, this message translates to:
  /// **'+ 2 ans (déjà en circulation)'**
  String get offset2Years;

  /// No description provided for @offset4Years.
  ///
  /// In fr, this message translates to:
  /// **'+ 4 ans (véhicule neuf)'**
  String get offset4Years;

  /// No description provided for @offset1Year.
  ///
  /// In fr, this message translates to:
  /// **'+ 1 an'**
  String get offset1Year;

  /// No description provided for @appearance.
  ///
  /// In fr, this message translates to:
  /// **'Apparence'**
  String get appearance;

  /// No description provided for @themeSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get themeDark;

  /// No description provided for @language.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In fr, this message translates to:
  /// **'Langue du téléphone'**
  String get languageSystem;

  /// No description provided for @languageFr.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get languageFr;

  /// No description provided for @languageEn.
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get languageEn;

  /// No description provided for @languageEs.
  ///
  /// In fr, this message translates to:
  /// **'Español'**
  String get languageEs;

  /// No description provided for @languageDe.
  ///
  /// In fr, this message translates to:
  /// **'Deutsch'**
  String get languageDe;

  /// No description provided for @languageAr.
  ///
  /// In fr, this message translates to:
  /// **'العربية'**
  String get languageAr;

  /// No description provided for @alertsAndNotifications.
  ///
  /// In fr, this message translates to:
  /// **'Alertes et notifications'**
  String get alertsAndNotifications;

  /// No description provided for @householdHolders.
  ///
  /// In fr, this message translates to:
  /// **'Titulaires du foyer'**
  String get householdHolders;

  /// No description provided for @addHolder.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un titulaire'**
  String get addHolder;

  /// No description provided for @iapNote.
  ///
  /// In fr, this message translates to:
  /// **'Foyer illimité et export PDF sont prévus en achat unique. En v1, tout est ouvert.'**
  String get iapNote;

  /// No description provided for @backup.
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarde'**
  String get backup;

  /// No description provided for @exportJson.
  ///
  /// In fr, this message translates to:
  /// **'Exporter JSON'**
  String get exportJson;

  /// No description provided for @exportJsonSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Fichier local, sans photos.'**
  String get exportJsonSubtitle;

  /// No description provided for @importJson.
  ///
  /// In fr, this message translates to:
  /// **'Importer JSON'**
  String get importJson;

  /// No description provided for @importDone.
  ///
  /// In fr, this message translates to:
  /// **'Import terminé.'**
  String get importDone;

  /// No description provided for @privacy.
  ///
  /// In fr, this message translates to:
  /// **'Confidentialité'**
  String get privacy;

  /// No description provided for @privacyText.
  ///
  /// In fr, this message translates to:
  /// **'Les dates restent sur cet appareil. Pas de compte, pas d’analytics, pas de photo de pièce d’identité. Cette app n’est pas un service administratif. Des publicités Google AdMob peuvent s’afficher ; dans l’Espace économique européen, votre consentement est demandé.'**
  String get privacyText;

  /// No description provided for @privacyAdsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Publicité'**
  String get privacyAdsTitle;

  /// No description provided for @privacyAdsBody.
  ///
  /// In fr, this message translates to:
  /// **'Une bannière peut apparaître en bas de l’accueil. Un interstitiel n’est proposé qu’après un enregistrement, jamais au lancement ni en quittant l’app.'**
  String get privacyAdsBody;

  /// No description provided for @manageAdsConsent.
  ///
  /// In fr, this message translates to:
  /// **'Gérer le consentement publicitaire'**
  String get manageAdsConsent;

  /// No description provided for @deleteHolderTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer ce titulaire ?'**
  String get deleteHolderTitle;

  /// No description provided for @deleteHolderBody.
  ///
  /// In fr, this message translates to:
  /// **'« {name} » et ses papiers seront retirés.'**
  String deleteHolderBody(String name);

  /// No description provided for @newHolder.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau titulaire'**
  String get newHolder;

  /// No description provided for @firstName.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get firstName;

  /// No description provided for @ok.
  ///
  /// In fr, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @deviceAlerts.
  ///
  /// In fr, this message translates to:
  /// **'Alertes de l’appareil'**
  String get deviceAlerts;

  /// No description provided for @deviceAlertsSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Rappels le matin à 9 h et alerte le jour J.'**
  String get deviceAlertsSubtitle;

  /// No description provided for @notifsDisabled.
  ///
  /// In fr, this message translates to:
  /// **'Les notifications sont désactivées pour cette application.'**
  String get notifsDisabled;

  /// No description provided for @allowAlerts.
  ///
  /// In fr, this message translates to:
  /// **'Autoriser les alertes'**
  String get allowAlerts;

  /// No description provided for @defaultReminders.
  ///
  /// In fr, this message translates to:
  /// **'Rappels par défaut'**
  String get defaultReminders;

  /// No description provided for @testNotifSent.
  ///
  /// In fr, this message translates to:
  /// **'Notification de test envoyée.'**
  String get testNotifSent;

  /// No description provided for @sendTestNotif.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer une notification test'**
  String get sendTestNotif;

  /// No description provided for @notifExpiresToday.
  ///
  /// In fr, this message translates to:
  /// **'Expire aujourd’hui ({date}).'**
  String notifExpiresToday(String date);

  /// No description provided for @notifDueInDays.
  ///
  /// In fr, this message translates to:
  /// **'Échéance dans {days} jours ({date}).'**
  String notifDueInDays(int days, String date);

  /// No description provided for @testNotifTitle.
  ///
  /// In fr, this message translates to:
  /// **'Alertes Échéances'**
  String get testNotifTitle;

  /// No description provided for @testNotifBody.
  ///
  /// In fr, this message translates to:
  /// **'Les notifications fonctionnent. Vous serez prévenu avant chaque date.'**
  String get testNotifBody;

  /// No description provided for @widgetNoDeadline.
  ///
  /// In fr, this message translates to:
  /// **'Aucune échéance'**
  String get widgetNoDeadline;

  /// No description provided for @widgetAddPaper.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez un papier'**
  String get widgetAddPaper;

  /// No description provided for @deleteTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get deleteTooltip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
