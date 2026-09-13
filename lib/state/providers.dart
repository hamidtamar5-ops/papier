import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ads/ad_service.dart';
import '../data/backup_service.dart';
import '../data/notification_service.dart';
import '../data/repository.dart';
import '../data/settings_store.dart';
import '../data/widget_sync.dart';
import '../domain/models.dart';
import '../l10n/format.dart';

final repositoryProvider = Provider<PapierRepository>((ref) {
  return PapierRepository();
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final adServiceProvider = Provider<AdService>((ref) {
  final service = AdService();
  ref.onDispose(service.dispose);
  return service;
});

final widgetSyncProvider = Provider<WidgetSync>((ref) => WidgetSync());

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.watch(repositoryProvider));
});

final settingsStoreProvider = Provider<SettingsStore>((ref) => SettingsStore());

final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);

class SettingsNotifier extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() => ref.read(settingsStoreProvider).load();

  Future<void> saveSettings(AppSettings settings) async {
    await ref.read(settingsStoreProvider).save(settings);
    state = AsyncData(settings);
    await ref.read(documentsProvider.notifier).syncSideEffects();
  }
}

final titulairesProvider =
    AsyncNotifierProvider<TitulairesNotifier, List<Titulaire>>(
  TitulairesNotifier.new,
);

class TitulairesNotifier extends AsyncNotifier<List<Titulaire>> {
  @override
  Future<List<Titulaire>> build() async {
    final repo = ref.read(repositoryProvider);
    await repo.ensureDefaultTitulaire();
    return repo.titulaires();
  }

  Future<void> add(String prenom, int colorValue) async {
    await ref.read(repositoryProvider).insertTitulaire(
          Titulaire(id: 0, prenom: prenom, colorValue: colorValue),
        );
    ref.invalidateSelf();
    await ref.read(documentsProvider.notifier).syncSideEffects();
  }

  Future<void> rename(Titulaire titulaire) async {
    await ref.read(repositoryProvider).updateTitulaire(titulaire);
    ref.invalidateSelf();
  }

  Future<void> remove(int id) async {
    final current = state.value ?? const [];
    if (current.length <= 1) return;
    await ref.read(repositoryProvider).deleteTitulaire(id);
    ref.invalidateSelf();
    ref.invalidate(documentsProvider);
    await ref.read(documentsProvider.notifier).syncSideEffects();
  }
}

final documentsProvider =
    AsyncNotifierProvider<DocumentsNotifier, List<PapierDocument>>(
  DocumentsNotifier.new,
);

class DocumentsNotifier extends AsyncNotifier<List<PapierDocument>> {
  @override
  Future<List<PapierDocument>> build() async {
    return ref.read(repositoryProvider).documents();
  }

  Future<void> save(PapierDocument document) async {
    final repo = ref.read(repositoryProvider);
    if (document.id == 0) {
      await repo.insertDocument(document);
    } else {
      await repo.updateDocument(document);
    }
    ref.invalidateSelf();
    await future;
    await syncSideEffects();
  }

  Future<void> remove(int id) async {
    await ref.read(repositoryProvider).deleteDocument(id);
    ref.invalidateSelf();
    await future;
    await syncSideEffects();
  }

  Future<void> reloadAfterImport() async {
    ref.invalidate(titulairesProvider);
    ref.invalidateSelf();
    await future;
    await syncSideEffects();
  }

  Future<void> syncSideEffects() async {
    final documents = await ref.read(repositoryProvider).documents();
    final titulaires = await ref.read(repositoryProvider).titulaires();
    final settings = await ref.read(settingsStoreProvider).load();
    final locale = localeFromSettings(settings);
    final notifications = ref.read(notificationServiceProvider);
    if (settings.notificationsEnabled) {
      await notifications.rescheduleAll(documents, locale: locale);
    } else {
      await notifications.cancelAll();
    }
    await ref.read(widgetSyncProvider).update(
          documents: documents,
          titulaires: titulaires,
          locale: locale,
        );
  }
}
