import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../domain/echeance.dart';
import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../l10n/format.dart';
import '../state/providers.dart';
import 'document_form_page.dart';
import 'kind_style.dart';
import 'settings_page.dart';
import 'widgets/ad_banner.dart';
import 'widgets/alert_banner.dart';
import 'widgets/document_card.dart';
import 'widgets/status_chip.dart';
import 'widgets/surface_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(documentsProvider);
    final titulaires = ref.watch(titulairesProvider);
    final settings = ref.watch(settingsProvider);

    return documents.when(
      loading: () {
        final l10n = AppLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(title: Text(l10n.appTitle)),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
      error: (error, _) {
        final l10n = AppLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(title: Text(l10n.appTitle)),
          body: Center(child: Text(l10n.errorWithMessage('$error'))),
        );
      },
      data: (items) {
        final people = titulaires.value ?? const <Titulaire>[];
        final soonDays = soonWindow(
          settings.value?.defaultRemindDays ?? const [90, 30, 7],
        );
        return HomeView(
          documents: items,
          titulaires: people,
          soonDays: soonDays,
          bottomBar: const AdBannerSlot(),
          onAdd: () => _openForm(context, ref),
          onOpenSettings: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const SettingsPage()),
            );
          },
          onOpen: (doc) => _openForm(context, ref, document: doc),
          onDelete: (doc) =>
              ref.read(documentsProvider.notifier).remove(doc.id),
        );
      },
    );
  }

  Future<void> _openForm(
    BuildContext context,
    WidgetRef ref, {
    PapierDocument? document,
  }) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => DocumentFormPage(document: document),
      ),
    );
    if (saved == true && context.mounted) {
      await ref.read(adServiceProvider).showInterstitialAfterAction();
    }
  }
}

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.documents,
    required this.titulaires,
    required this.soonDays,
    required this.onAdd,
    required this.onOpenSettings,
    required this.onOpen,
    required this.onDelete,
    this.now,
    this.bottomBar,
  });

  final List<PapierDocument> documents;
  final List<Titulaire> titulaires;
  final int soonDays;
  final VoidCallback onAdd;
  final VoidCallback onOpenSettings;
  final ValueChanged<PapierDocument> onOpen;
  final ValueChanged<PapierDocument> onDelete;
  final DateTime? now;
  final Widget? bottomBar;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? _filterId;

  Titulaire? _titulaire(int id) {
    for (final t in widget.titulaires) {
      if (t.id == id) return t;
    }
    return null;
  }

  List<PapierDocument> get _visible {
    if (_filterId == null) return widget.documents;
    return widget.documents.where((d) => d.titulaireId == _filterId).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final clock = widget.now ?? DateTime.now();
    final visible = _visible;
    final digest = alertDigest(visible, clock);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.settings,
            onPressed: widget.onOpenSettings,
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: widget.onAdd,
        icon: const Icon(Icons.add),
        label: Text(l10n.addDocument),
      ),
      bottomNavigationBar: widget.bottomBar,
      body: widget.documents.isEmpty
          ? _EmptyState(onAdd: widget.onAdd)
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 108),
              children: [
                AlertBanner(digest: digest),
                if (digest.hasAlerts) const SizedBox(height: 12),
                if (visible.isNotEmpty) _NextDeadlineCard(
                  document: visible.first,
                  titulaire: _titulaire(visible.first.titulaireId),
                  soonDays: widget.soonDays,
                  now: clock,
                  onOpen: () => widget.onOpen(visible.first),
                ),
                if (widget.titulaires.length > 1) ...[
                  const SizedBox(height: 16),
                  _TitulaireFilter(
                    titulaires: widget.titulaires,
                    selectedId: _filterId,
                    onChanged: (id) => setState(() => _filterId = id),
                  ),
                ],
                if (visible.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      l10n.noDocsForPerson,
                      textAlign: TextAlign.center,
                    ),
                  )
                else ...[
                  ..._section(
                    context,
                    title: l10n.sectionRenew,
                    items: visible
                        .where(
                          (d) =>
                              statusOf(d.expiration, clock, soonDays: widget.soonDays) ==
                              EcheanceStatus.depasse,
                        )
                        .toList(),
                    clock: clock,
                  ),
                  ..._section(
                    context,
                    title: l10n.sectionWatch,
                    items: visible
                        .where(
                          (d) =>
                              statusOf(d.expiration, clock, soonDays: widget.soonDays) ==
                              EcheanceStatus.bientot,
                        )
                        .toList(),
                    clock: clock,
                  ),
                  ..._section(
                    context,
                    title: l10n.sectionOk,
                    items: visible
                        .where(
                          (d) =>
                              statusOf(d.expiration, clock, soonDays: widget.soonDays) ==
                              EcheanceStatus.ok,
                        )
                        .toList(),
                    clock: clock,
                  ),
                ],
              ],
            ),
    );
  }

  List<Widget> _section(
    BuildContext context, {
    required String title,
    required List<PapierDocument> items,
    required DateTime clock,
  }) {
    if (items.isEmpty) return const [];
    return [
      const SizedBox(height: 8),
      SectionTitle(title, count: items.length),
      ...items.map((doc) {
        return DocumentCard(
          document: doc,
          status: statusOf(doc.expiration, clock, soonDays: widget.soonDays),
          titulaire: _titulaire(doc.titulaireId),
          now: clock,
          onOpen: () => widget.onOpen(doc),
          onDelete: () => _confirmDelete(context, doc),
        );
      }),
    ];
  }

  Future<void> _confirmDelete(BuildContext context, PapierDocument doc) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteConfirmTitle),
        content: Text(
          AppLocalizations.of(context).deleteDocumentBody(doc.label),
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
    if (ok == true) widget.onDelete(doc);
  }
}

class _NextDeadlineCard extends StatelessWidget {
  const _NextDeadlineCard({
    required this.document,
    required this.titulaire,
    required this.soonDays,
    required this.now,
    required this.onOpen,
  });

  final PapierDocument document;
  final Titulaire? titulaire;
  final int soonDays;
  final DateTime now;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final formatter = DateFormat.yMMMMd(Localizations.localeOf(context).toString());
    final status = statusOf(document.expiration, now, soonDays: soonDays);
    final days = daysUntil(document.expiration, now);

    return SurfaceCard(
      color: scheme.primaryContainer,
      onTap: onOpen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.upcoming_outlined, color: scheme.onPrimaryContainer),
              const SizedBox(width: 8),
              Text(
                l10n.nextDeadline,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: scheme.onPrimaryContainer.withValues(alpha: 0.12),
                foregroundColor: scheme.onPrimaryContainer,
                child: Icon(iconOf(document.kind)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.label,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: scheme.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${titulaire?.prenom ?? ''} · ${formatter.format(document.expiration)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.onPrimaryContainer.withValues(alpha: 0.86),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              StatusChip(status: status),
              const SizedBox(width: 10),
              Text(
                localizedDaysLabel(l10n, days),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TitulaireFilter extends StatelessWidget {
  const _TitulaireFilter({
    required this.titulaires,
    required this.selectedId,
    required this.onChanged,
  });

  final List<Titulaire> titulaires;
  final int? selectedId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChip(
            label: Text(AppLocalizations.of(context).filterAll),
            selected: selectedId == null,
            onSelected: (_) => onChanged(null),
          ),
          const SizedBox(width: 8),
          for (final person in titulaires) ...[
            FilterChip(
              avatar: CircleAvatar(
                backgroundColor: Color(person.colorValue),
                radius: 8,
              ),
              label: Text(person.prenom),
              selected: selectedId == person.id,
              onSelected: (_) => onChanged(person.id),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.event_available_outlined,
                size: 44,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.emptyTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.emptySubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: Text(l10n.addDocument),
            ),
          ],
        ),
      ),
    );
  }
}
