// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Deadlines';

  @override
  String get settings => 'Settings';

  @override
  String get addDocument => 'Add a document';

  @override
  String errorWithMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get noDocsForPerson => 'No documents for this person.';

  @override
  String get sectionRenew => 'To renew';

  @override
  String get sectionWatch => 'Coming up';

  @override
  String get sectionOk => 'Up to date';

  @override
  String get deleteConfirmTitle => 'Delete?';

  @override
  String deleteDocumentBody(String label) {
    return 'Remove “$label” from the list.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get nextDeadline => 'Next deadline';

  @override
  String get filterAll => 'All';

  @override
  String get emptyTitle => 'No documents yet';

  @override
  String get emptySubtitle =>
      'Add a date (ID card, passport, MOT, insurance…). No photo is required.';

  @override
  String get statusOk => 'OK';

  @override
  String get statusSoon => 'Soon';

  @override
  String get statusOverdue => 'Overdue';

  @override
  String get expiredYesterday => 'expired yesterday';

  @override
  String expiredDays(int count) {
    return 'expired $count days ago';
  }

  @override
  String get expiresToday => 'expires today';

  @override
  String get inOneDay => 'in 1 day';

  @override
  String inDays(int count) {
    return 'in $count days';
  }

  @override
  String get digestTitleRenew => 'Documents to renew';

  @override
  String get digestTitleToday => 'Due today';

  @override
  String get digestTitleSoon => 'Upcoming deadline';

  @override
  String digestBodyOneOverdue(String label) {
    return '$label is overdue.';
  }

  @override
  String digestBodyOneToday(String label) {
    return '$label expires today.';
  }

  @override
  String digestBodyOneSoon(String label) {
    return '$label expires within 7 days.';
  }

  @override
  String get digestPartOneOverdue => '1 overdue document';

  @override
  String digestPartManyOverdue(int count) {
    return '$count overdue documents';
  }

  @override
  String get digestPartOneToday => '1 today';

  @override
  String digestPartManyToday(int count) {
    return '$count today';
  }

  @override
  String get digestPartOneSoon => '1 within 7 days';

  @override
  String digestPartManySoon(int count) {
    return '$count within 7 days';
  }

  @override
  String get aDocument => 'A document';

  @override
  String get addPaper => 'Add a document';

  @override
  String get edit => 'Edit';

  @override
  String get documentType => 'Document type';

  @override
  String get details => 'Details';

  @override
  String get labelField => 'Label';

  @override
  String get holder => 'Holder';

  @override
  String get computeFromStart => 'Calculate from a start date';

  @override
  String get startDate => 'Start date';

  @override
  String get expirationDate => 'Expiry date';

  @override
  String get choose => 'Choose';

  @override
  String get alertsAndReminders => 'Alerts and reminders';

  @override
  String get reminderHint =>
      'Notification at 9 a.m., plus an alert on the due day.';

  @override
  String get notes => 'Notes';

  @override
  String get notesHint => 'Notes (optional, no ID numbers)';

  @override
  String get save => 'Save';

  @override
  String get chooseHolderAndDate => 'Choose a holder and a date.';

  @override
  String get kindCni => 'ID card';

  @override
  String get kindPasseport => 'Passport';

  @override
  String get kindPermis => 'Driving licence';

  @override
  String get kindCarteVitale => 'Health card';

  @override
  String get kindCarteGrise => 'Vehicle registration';

  @override
  String get kindControleTechnique => 'Vehicle inspection';

  @override
  String get kindAssuranceAuto => 'Car insurance';

  @override
  String get kindPersonnalise => 'Other document';

  @override
  String get hintCni =>
      'Enter the expiry date printed on the card. Usually 10 years after issue — always check the card.';

  @override
  String get hintPasseport =>
      'Expiry date on the passport. Often 10 years (adult) or 5 years (child).';

  @override
  String get hintPermis =>
      'Enter the date shown on the licence. No duration is assumed.';

  @override
  String get hintCarteVitale =>
      'Enter the date you want to track, if you know it.';

  @override
  String get hintCarteGrise =>
      'Enter the date to watch (no scan of the certificate).';

  @override
  String get hintControleTechnique =>
      'Validity date, or calculate from the last inspection (+2 years, or +4 years for a new vehicle).';

  @override
  String get hintAssuranceAuto =>
      'Due date, or +1 year from the start of the policy.';

  @override
  String get hintPersonnalise => 'Free label and date. No photo, no ID number.';

  @override
  String get offset2Years => '+ 2 years (already in use)';

  @override
  String get offset4Years => '+ 4 years (new vehicle)';

  @override
  String get offset1Year => '+ 1 year';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'Phone language';

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
  String get alertsAndNotifications => 'Alerts and notifications';

  @override
  String get householdHolders => 'Household members';

  @override
  String get addHolder => 'Add a holder';

  @override
  String get iapNote =>
      'Unlimited household and PDF export are planned as a one-time purchase. In v1, everything is unlocked.';

  @override
  String get backup => 'Backup';

  @override
  String get exportJson => 'Export JSON';

  @override
  String get exportJsonSubtitle => 'Local file, no photos.';

  @override
  String get importJson => 'Import JSON';

  @override
  String get importDone => 'Import complete.';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyText =>
      'Dates stay on this device. No account, no analytics, no ID photos. This app is not a government service. Google AdMob ads may appear; in the European Economic Area, your consent is requested.';

  @override
  String get privacyAdsTitle => 'Advertising';

  @override
  String get privacyAdsBody =>
      'A banner may appear at the bottom of Home. An interstitial is only offered after you save, never at launch or when leaving the app.';

  @override
  String get manageAdsConsent => 'Manage advertising consent';

  @override
  String get deleteHolderTitle => 'Delete this holder?';

  @override
  String deleteHolderBody(String name) {
    return '“$name” and their documents will be removed.';
  }

  @override
  String get newHolder => 'New holder';

  @override
  String get firstName => 'First name';

  @override
  String get ok => 'OK';

  @override
  String get deviceAlerts => 'Device alerts';

  @override
  String get deviceAlertsSubtitle =>
      'Reminders at 9 a.m. and an alert on the due day.';

  @override
  String get notifsDisabled => 'Notifications are turned off for this app.';

  @override
  String get allowAlerts => 'Allow alerts';

  @override
  String get defaultReminders => 'Default reminders';

  @override
  String get testNotifSent => 'Test notification sent.';

  @override
  String get sendTestNotif => 'Send a test notification';

  @override
  String notifExpiresToday(String date) {
    return 'Expires today ($date).';
  }

  @override
  String notifDueInDays(int days, String date) {
    return 'Due in $days days ($date).';
  }

  @override
  String get testNotifTitle => 'Deadline alerts';

  @override
  String get testNotifBody =>
      'Notifications work. You will be reminded before each date.';

  @override
  String get widgetNoDeadline => 'No deadline';

  @override
  String get widgetAddPaper => 'Add a document';

  @override
  String get deleteTooltip => 'Delete';
}
