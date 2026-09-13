// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Fristen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get addDocument => 'Dokument hinzufügen';

  @override
  String errorWithMessage(String error) {
    return 'Fehler: $error';
  }

  @override
  String get noDocsForPerson => 'Keine Dokumente für diese Person.';

  @override
  String get sectionRenew => 'Zu erneuern';

  @override
  String get sectionWatch => 'Bald fällig';

  @override
  String get sectionOk => 'Aktuell';

  @override
  String get deleteConfirmTitle => 'Löschen?';

  @override
  String deleteDocumentBody(String label) {
    return '„$label“ aus der Liste entfernen.';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get nextDeadline => 'Nächste Frist';

  @override
  String get filterAll => 'Alle';

  @override
  String get emptyTitle => 'Noch keine Dokumente';

  @override
  String get emptySubtitle =>
      'Fügen Sie ein Datum hinzu (Ausweis, Reisepass, TÜV, Versicherung…). Es wird kein Foto verlangt.';

  @override
  String get statusOk => 'OK';

  @override
  String get statusSoon => 'Bald';

  @override
  String get statusOverdue => 'Abgelaufen';

  @override
  String get expiredYesterday => 'gestern abgelaufen';

  @override
  String expiredDays(int count) {
    return 'seit $count Tagen abgelaufen';
  }

  @override
  String get expiresToday => 'läuft heute ab';

  @override
  String get inOneDay => 'in 1 Tag';

  @override
  String inDays(int count) {
    return 'in $count Tagen';
  }

  @override
  String get digestTitleRenew => 'Dokumente erneuern';

  @override
  String get digestTitleToday => 'Heute fällig';

  @override
  String get digestTitleSoon => 'Bevorstehende Frist';

  @override
  String digestBodyOneOverdue(String label) {
    return '$label ist abgelaufen.';
  }

  @override
  String digestBodyOneToday(String label) {
    return '$label läuft heute ab.';
  }

  @override
  String digestBodyOneSoon(String label) {
    return '$label läuft in weniger als 7 Tagen ab.';
  }

  @override
  String get digestPartOneOverdue => '1 abgelaufenes Dokument';

  @override
  String digestPartManyOverdue(int count) {
    return '$count abgelaufene Dokumente';
  }

  @override
  String get digestPartOneToday => '1 heute';

  @override
  String digestPartManyToday(int count) {
    return '$count heute';
  }

  @override
  String get digestPartOneSoon => '1 in weniger als 7 Tagen';

  @override
  String digestPartManySoon(int count) {
    return '$count in weniger als 7 Tagen';
  }

  @override
  String get aDocument => 'Ein Dokument';

  @override
  String get addPaper => 'Dokument hinzufügen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get documentType => 'Dokumenttyp';

  @override
  String get details => 'Details';

  @override
  String get labelField => 'Bezeichnung';

  @override
  String get holder => 'Inhaber';

  @override
  String get computeFromStart => 'Ab einem Startdatum berechnen';

  @override
  String get startDate => 'Startdatum';

  @override
  String get expirationDate => 'Ablaufdatum';

  @override
  String get choose => 'Wählen';

  @override
  String get alertsAndReminders => 'Hinweise und Erinnerungen';

  @override
  String get reminderHint =>
      'Benachrichtigung um 9 Uhr, plus ein Hinweis am Fälligkeitstag.';

  @override
  String get notes => 'Notizen';

  @override
  String get notesHint => 'Notizen (optional, keine Ausweisnummer)';

  @override
  String get save => 'Speichern';

  @override
  String get chooseHolderAndDate => 'Wählen Sie einen Inhaber und ein Datum.';

  @override
  String get kindCni => 'Personalausweis';

  @override
  String get kindPasseport => 'Reisepass';

  @override
  String get kindPermis => 'Führerschein';

  @override
  String get kindCarteVitale => 'Versichertenkarte';

  @override
  String get kindCarteGrise => 'Fahrzeugschein';

  @override
  String get kindControleTechnique => 'Hauptuntersuchung';

  @override
  String get kindAssuranceAuto => 'Kfz-Versicherung';

  @override
  String get kindPersonnalise => 'Anderes Dokument';

  @override
  String get hintCni =>
      'Geben Sie das auf der Karte stehende Ablaufdatum ein. Übliche Dauer: 10 Jahre nach Ausstellung — prüfen Sie immer die Karte.';

  @override
  String get hintPasseport =>
      'Ablaufdatum im Reisepass. Oft 10 Jahre (Erwachsene) oder 5 Jahre (Kinder).';

  @override
  String get hintPermis =>
      'Geben Sie das auf dem Dokument stehende Datum ein. Es wird keine Dauer angenommen.';

  @override
  String get hintCarteVitale =>
      'Geben Sie das Datum ein, das Sie überwachen möchten, falls bekannt.';

  @override
  String get hintCarteGrise =>
      'Geben Sie das zu überwachende Datum ein (kein Scan des Dokuments).';

  @override
  String get hintControleTechnique =>
      'Gültigkeitsdatum oder Berechnung ab der letzten Prüfung (+2 Jahre, oder +4 Jahre bei Neufahrzeug).';

  @override
  String get hintAssuranceAuto =>
      'Fälligkeitsdatum oder +1 Jahr ab Vertragsbeginn.';

  @override
  String get hintPersonnalise =>
      'Freie Bezeichnung und Datum. Kein Foto, keine Ausweisnummer.';

  @override
  String get offset2Years => '+ 2 Jahre (bereits im Verkehr)';

  @override
  String get offset4Years => '+ 4 Jahre (Neufahrzeug)';

  @override
  String get offset1Year => '+ 1 Jahr';

  @override
  String get appearance => 'Darstellung';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get language => 'Sprache';

  @override
  String get languageSystem => 'Telefonsprache';

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
  String get alertsAndNotifications => 'Hinweise und Benachrichtigungen';

  @override
  String get householdHolders => 'Haushaltsmitglieder';

  @override
  String get addHolder => 'Inhaber hinzufügen';

  @override
  String get iapNote =>
      'Unbegrenzter Haushalt und PDF-Export sind als Einmalkauf geplant. In v1 ist alles freigeschaltet.';

  @override
  String get backup => 'Sicherung';

  @override
  String get exportJson => 'JSON exportieren';

  @override
  String get exportJsonSubtitle => 'Lokale Datei, ohne Fotos.';

  @override
  String get importJson => 'JSON importieren';

  @override
  String get importDone => 'Import abgeschlossen.';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get privacyText =>
      'Die Daten bleiben auf diesem Gerät. Kein Konto, keine Analysen, kein Ausweisfoto. Diese App ist kein Verwaltungsdienst. Es können Google-AdMob-Anzeigen erscheinen; im Europäischen Wirtschaftsraum wird Ihre Einwilligung eingeholt.';

  @override
  String get privacyAdsTitle => 'Werbung';

  @override
  String get privacyAdsBody =>
      'Unten auf der Startseite kann ein Banner erscheinen. Ein Interstitial erscheint nur nach dem Speichern, nie beim Start oder beim Verlassen der App.';

  @override
  String get manageAdsConsent => 'Werbeeinwilligung verwalten';

  @override
  String get deleteHolderTitle => 'Diesen Inhaber löschen?';

  @override
  String deleteHolderBody(String name) {
    return '„$name“ und die zugehörigen Dokumente werden entfernt.';
  }

  @override
  String get newHolder => 'Neuer Inhaber';

  @override
  String get firstName => 'Vorname';

  @override
  String get ok => 'OK';

  @override
  String get deviceAlerts => 'Gerätehinweise';

  @override
  String get deviceAlertsSubtitle =>
      'Erinnerungen um 9 Uhr und ein Hinweis am Fälligkeitstag.';

  @override
  String get notifsDisabled =>
      'Benachrichtigungen sind für diese App deaktiviert.';

  @override
  String get allowAlerts => 'Hinweise erlauben';

  @override
  String get defaultReminders => 'Standarderinnerungen';

  @override
  String get testNotifSent => 'Testbenachrichtigung gesendet.';

  @override
  String get sendTestNotif => 'Testbenachrichtigung senden';

  @override
  String notifExpiresToday(String date) {
    return 'Läuft heute ab ($date).';
  }

  @override
  String notifDueInDays(int days, String date) {
    return 'Fällig in $days Tagen ($date).';
  }

  @override
  String get testNotifTitle => 'Fristen-Hinweise';

  @override
  String get testNotifBody =>
      'Benachrichtigungen funktionieren. Sie werden vor jedem Datum erinnert.';

  @override
  String get widgetNoDeadline => 'Keine Frist';

  @override
  String get widgetAddPaper => 'Dokument hinzufügen';

  @override
  String get deleteTooltip => 'Löschen';
}
