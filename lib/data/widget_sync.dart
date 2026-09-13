import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

import '../domain/echeance.dart';
import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../l10n/format.dart';

class WidgetSync {
  static const androidName = 'PapierWidgetProvider';

  Future<void> update({
    required List<PapierDocument> documents,
    required List<Titulaire> titulaires,
    Locale? locale,
  }) async {
    final l10n = lookupAppLocalizations(locale ?? const Locale('fr'));
    final active = documents.where((d) => !d.archived).toList()
      ..sort((a, b) => a.expiration.compareTo(b.expiration));
    if (active.isEmpty) {
      await HomeWidget.saveWidgetData<String>('title', l10n.widgetNoDeadline);
      await HomeWidget.saveWidgetData<String>('subtitle', l10n.widgetAddPaper);
      await HomeWidget.saveWidgetData<String>('days', '—');
    } else {
      final next = active.first;
      final titulaire = titulaires.cast<Titulaire?>().firstWhere(
            (t) => t?.id == next.titulaireId,
            orElse: () => null,
          );
      final days = daysUntil(next.expiration, DateTime.now());
      await HomeWidget.saveWidgetData<String>('title', next.label);
      await HomeWidget.saveWidgetData<String>(
        'subtitle',
        titulaire?.prenom ?? '',
      );
      await HomeWidget.saveWidgetData<String>(
        'days',
        localizedDaysLabel(l10n, days),
      );
    }
    await HomeWidget.updateWidget(
      androidName: androidName,
      qualifiedAndroidName: 'com.example.papier.$androidName',
    );
  }
}
