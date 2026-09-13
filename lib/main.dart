import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/notification_service.dart';
import 'data/repository.dart';
import 'data/settings_store.dart';
import 'data/widget_sync.dart';
import 'l10n/format.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notifications = NotificationService();
  await notifications.init();
  await notifications.requestPermission();

  final repository = PapierRepository();
  await repository.ensureDefaultTitulaire();
  final documents = await repository.documents();
  final titulaires = await repository.titulaires();
  final settings = await SettingsStore().load();
  final locale = localeFromSettings(settings);
  if (settings.notificationsEnabled) {
    await notifications.rescheduleAll(documents, locale: locale);
    await notifications.showUrgentDigest(documents, locale: locale);
  } else {
    await notifications.cancelAll();
  }
  await WidgetSync().update(
    documents: documents,
    titulaires: titulaires,
    locale: locale,
  );

  runApp(const ProviderScope(child: PapierApp()));
}
