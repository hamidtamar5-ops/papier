import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../domain/models.dart';
import '../domain/presets.dart';
import '../l10n/app_localizations.dart';
import '../l10n/format.dart';
import '../state/providers.dart';
import 'widgets/surface_card.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final people = ref.watch(titulairesProvider).value ?? const <Titulaire>[];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          SectionTitle(l10n.appearance),
          SurfaceCard(
            child: SegmentedButton<ThemePreference>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: ThemePreference.system,
                  label: Text(l10n.themeSystem),
                  icon: const Icon(Icons.brightness_auto_outlined, size: 18),
                ),
                ButtonSegment(
                  value: ThemePreference.light,
                  label: Text(l10n.themeLight),
                  icon: const Icon(Icons.light_mode_outlined, size: 18),
                ),
                ButtonSegment(
                  value: ThemePreference.dark,
                  label: Text(l10n.themeDark),
                  icon: const Icon(Icons.dark_mode_outlined, size: 18),
                ),
              ],
              selected: {settings.theme},
              onSelectionChanged: (value) {
                ref.read(settingsProvider.notifier).saveSettings(
                      settings.copyWith(theme: value.first),
                    );
              },
            ),
          ),
          const SizedBox(height: 8),
          SectionTitle(l10n.language),
          SurfaceCard(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: RadioGroup<AppLanguage>(
              groupValue: settings.language,
              onChanged: (value) {
                if (value == null) return;
                ref.read(settingsProvider.notifier).saveSettings(
                      settings.copyWith(language: value),
                    );
              },
              child: Column(
                children: [
                  for (final language in AppLanguage.values)
                    RadioListTile<AppLanguage>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(languageLabel(l10n, language)),
                      value: language,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SectionTitle(l10n.alertsAndNotifications),
          _NotificationsSection(settings: settings),
          const SizedBox(height: 8),
          SectionTitle(l10n.householdHolders),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < people.length; i++) ...[
                  if (i > 0) const Divider(height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Color(people[i].colorValue),
                      child: Text(
                        people[i].prenom.characters.first.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(people[i].prenom),
                    trailing: people.length > 1
                        ? IconButton(
                            tooltip: l10n.deleteTooltip,
                            onPressed: () =>
                                _confirmRemoveTitulaire(context, ref, people[i]),
                            icon: const Icon(Icons.delete_outline),
                          )
                        : null,
                    onTap: () => _editTitulaire(context, ref, people[i]),
                  ),
                ],
                TextButton.icon(
                  onPressed: () => _editTitulaire(context, ref, null),
                  icon: const Icon(Icons.person_add_outlined),
                  label: Text(l10n.addHolder),
                ),
                if (!kIapEnabled)
                  Text(
                    l10n.iapNote,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionTitle(l10n.backup),
          SurfaceCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.ios_share),
                  title: Text(l10n.exportJson),
                  subtitle: Text(l10n.exportJsonSubtitle),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => ref.read(backupServiceProvider).exportJson(),
                ),
                const Divider(height: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.file_open_outlined),
                  title: Text(l10n.importJson),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final ok = await ref.read(backupServiceProvider).importJson();
                    if (ok) {
                      await ref.read(documentsProvider.notifier).reloadAfterImport();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.importDone)),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionTitle(l10n.privacyAdsTitle),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.privacyAdsBody,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton.icon(
                  onPressed: () =>
                      ref.read(adServiceProvider).showPrivacyOptions(),
                  icon: const Icon(Icons.ads_click_outlined),
                  label: Text(l10n.manageAdsConsent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionTitle(l10n.privacy),
          SurfaceCard(
            child: Text(
              l10n.privacyText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmRemoveTitulaire(
    BuildContext context,
    WidgetRef ref,
    Titulaire person,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteHolderTitle),
        content: Text(
          AppLocalizations.of(context).deleteHolderBody(person.prenom),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).delete),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(titulairesProvider.notifier).remove(person.id);
    }
  }

  Future<void> _editTitulaire(
    BuildContext context,
    WidgetRef ref,
    Titulaire? existing,
  ) async {
    final controller = TextEditingController(text: existing?.prenom ?? '');
    var color = existing?.colorValue ??
        titulaireColors[(ref.read(titulairesProvider).value?.length ?? 0) %
            titulaireColors.length];
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                existing == null
                    ? AppLocalizations.of(context).newHolder
                    : AppLocalizations.of(context).edit,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).firstName,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final value in titulaireColors)
                        ChoiceChip(
                          label: const SizedBox(width: 16, height: 16),
                          selected: color == value,
                          selectedColor: Color(value),
                          backgroundColor: Color(value).withValues(alpha: 0.4),
                          onSelected: (_) => setState(() => color = value),
                        ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(AppLocalizations.of(context).cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(AppLocalizations.of(context).ok),
                ),
              ],
            );
          },
        );
      },
    );
    final prenom = controller.text.trim();
    controller.dispose();
    if (ok != true || prenom.isEmpty) return;
    if (existing == null) {
      await ref.read(titulairesProvider.notifier).add(prenom, color);
    } else {
      await ref
          .read(titulairesProvider.notifier)
          .rename(existing.copyWith(prenom: prenom, colorValue: color));
    }
  }
}

class _NotificationsSection extends ConsumerStatefulWidget {
  const _NotificationsSection({required this.settings});

  final AppSettings settings;

  @override
  ConsumerState<_NotificationsSection> createState() =>
      _NotificationsSectionState();
}

class _NotificationsSectionState extends ConsumerState<_NotificationsSection> {
  PermissionStatus? _permission;

  @override
  void initState() {
    super.initState();
    _refreshPermission();
  }

  Future<void> _refreshPermission() async {
    final status = await Permission.notification.status;
    if (mounted) setState(() => _permission = status);
  }

  Future<void> _requestPermission() async {
    await ref.read(notificationServiceProvider).requestPermission();
    await _refreshPermission();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = widget.settings;
    final scheme = Theme.of(context).colorScheme;
    final denied = _permission?.isDenied == true ||
        _permission?.isPermanentlyDenied == true;

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: Icon(
              settings.notificationsEnabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined,
            ),
            title: Text(l10n.deviceAlerts),
            subtitle: Text(l10n.deviceAlertsSubtitle),
            value: settings.notificationsEnabled,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).saveSettings(
                    settings.copyWith(notificationsEnabled: value),
                  );
            },
          ),
          if (settings.notificationsEnabled && denied) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.notifsDisabled,
                    style: TextStyle(color: scheme.onErrorContainer),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.tonal(
                    onPressed: () async {
                      if (_permission?.isPermanentlyDenied == true) {
                        await openAppSettings();
                      } else {
                        await _requestPermission();
                      }
                    },
                    child: Text(l10n.allowAlerts),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            l10n.defaultReminders,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final day in const [90, 30, 7, 1])
                FilterChip(
                  label: Text('J-$day'),
                  selected: settings.defaultRemindDays.contains(day),
                  onSelected: (selected) {
                    final next = [...settings.defaultRemindDays];
                    if (selected) {
                      next.add(day);
                    } else {
                      next.remove(day);
                    }
                    next.sort((a, b) => b.compareTo(a));
                    ref.read(settingsProvider.notifier).saveSettings(
                          settings.copyWith(defaultRemindDays: next),
                        );
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: settings.notificationsEnabled
                ? () async {
                    final locale = Localizations.localeOf(context);
                    await _requestPermission();
                    await ref
                        .read(notificationServiceProvider)
                        .showTestAlert(locale: locale);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.testNotifSent)),
                      );
                    }
                  }
                : null,
            icon: const Icon(Icons.notification_add_outlined),
            label: Text(l10n.sendTestNotif),
          ),
        ],
      ),
    );
  }
}
