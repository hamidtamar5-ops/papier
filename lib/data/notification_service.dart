import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../domain/echeance.dart';
import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../l10n/format.dart';

class NotificationService {
  NotificationService();

  static const digestId = 900001;
  static const testId = 900002;
  static const _digestKey = 'last_alert_digest_day';

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  static const _reminderDetails = AndroidNotificationDetails(
    'echeances_rappels',
    'Rappels',
    channelDescription: 'Rappels programmés avant une date de papier',
    importance: Importance.high,
    priority: Priority.high,
    category: AndroidNotificationCategory.reminder,
    playSound: true,
    enableVibration: true,
  );

  static const _alertDetails = AndroidNotificationDetails(
    'echeances_alertes',
    'Alertes',
    channelDescription: 'Papiers dépassés ou à renouveler aujourd’hui',
    importance: Importance.high,
    priority: Priority.high,
    category: AndroidNotificationCategory.alarm,
    playSound: true,
    enableVibration: true,
  );

  Future<void> init() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    final name = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(name.identifier));

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      const InitializationSettings(android: android),
    );
    _ready = true;
  }

  Future<void> requestPermission() async {
    await Permission.notification.request();
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> cancelAll() async {
    await init();
    await _plugin.cancelAll();
  }

  Future<void> rescheduleAll(
    List<PapierDocument> documents, {
    Locale? locale,
  }) async {
    await init();
    final pending = await _plugin.pendingNotificationRequests();
    for (final request in pending) {
      if (request.id < 900000) {
        await _plugin.cancel(request.id);
      }
    }

    final l10n = lookupAppLocalizations(locale ?? const Locale('fr'));
    final now = DateTime.now();
    for (final document in documents) {
      if (document.archived) continue;
      final days = <int>{...document.remindDays, 0}.toList()
        ..sort((a, b) => b.compareTo(a));
      var index = 0;
      for (final offset in days) {
        final when = DateTime(
          document.expiration.year,
          document.expiration.month,
          document.expiration.day,
          9,
        ).subtract(Duration(days: offset));
        if (when.isAfter(now)) {
          await _schedule(
            id: document.id * 10 + index,
            when: when,
            title: document.label,
            body: offset == 0
                ? l10n.notifExpiresToday(_format(document.expiration))
                : l10n.notifDueInDays(offset, _format(document.expiration)),
          );
        }
        index += 1;
      }
    }
  }

  Future<void> showUrgentDigest(
    List<PapierDocument> documents, {
    Locale? locale,
  }) async {
    await init();
    final l10n = lookupAppLocalizations(locale ?? const Locale('fr'));
    final digest = alertDigest(documents, DateTime.now());
    if (!digest.hasAlerts) return;

    final prefs = await SharedPreferences.getInstance();
    final today = _dayKey(DateTime.now());
    if (prefs.getString(_digestKey) == today) return;
    await prefs.setString(_digestKey, today);
    final title = localizedDigestTitle(l10n, digest);
    final body = localizedDigestBody(l10n, digest);

    await _plugin.show(
      digestId,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _alertDetails.channelId,
          _alertDetails.channelName,
          channelDescription: _alertDetails.channelDescription,
          importance: Importance.high,
          priority: Priority.high,
          category: AndroidNotificationCategory.alarm,
          playSound: true,
          enableVibration: true,
          styleInformation: BigTextStyleInformation(body),
        ),
      ),
    );
  }

  Future<void> showTestAlert({Locale? locale}) async {
    await init();
    await requestPermission();
    final l10n = lookupAppLocalizations(locale ?? const Locale('fr'));
    await _plugin.show(
      testId,
      l10n.testNotifTitle,
      l10n.testNotifBody,
      const NotificationDetails(android: _alertDetails),
    );
  }

  Future<void> _schedule({
    required int id,
    required DateTime when,
    required String title,
    required String body,
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(when, tz.local),
      const NotificationDetails(android: _reminderDetails),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  String _format(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
  }

  String _dayKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
