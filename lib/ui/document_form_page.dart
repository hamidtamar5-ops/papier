import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../domain/models.dart';
import '../domain/presets.dart';
import '../l10n/app_localizations.dart';
import '../l10n/format.dart';
import '../state/providers.dart';
import 'kind_style.dart';
import 'widgets/surface_card.dart';

class DocumentFormPage extends ConsumerStatefulWidget {
  const DocumentFormPage({super.key, this.document});

  final PapierDocument? document;

  @override
  ConsumerState<DocumentFormPage> createState() => _DocumentFormPageState();
}

class _DocumentFormPageState extends ConsumerState<DocumentFormPage> {
  late DocumentKind _kind;
  late TextEditingController _label;
  late TextEditingController _notes;
  DateTime? _expiration;
  DateTime? _start;
  int? _offsetYears;
  bool _computeFromStart = false;
  int? _titulaireId;
  late List<int> _remindDays;

  @override
  void initState() {
    super.initState();
    final doc = widget.document;
    final settings = ref.read(settingsProvider).value;
    _kind = doc?.kind ?? DocumentKind.cni;
    _label = TextEditingController(text: doc?.label ?? '');
    _notes = TextEditingController(text: doc?.notes ?? '');
    _expiration = doc?.expiration;
    _remindDays = List<int>.from(
      doc?.remindDays ?? settings?.defaultRemindDays ?? const [90, 30, 7],
    );
    _titulaireId = doc?.titulaireId;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.document == null && _label.text.isEmpty) {
      _label.text = localizedKind(AppLocalizations.of(context), _kind);
    }
  }

  @override
  void dispose() {
    _label.dispose();
    _notes.dispose();
    super.dispose();
  }

  DocumentPreset get _preset => presetOf(_kind);

  Future<void> _pickDate({required bool start}) async {
    final initial = start
        ? (_start ?? DateTime.now())
        : (_expiration ?? DateTime.now());
    final l10n = AppLocalizations.of(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: Localizations.localeOf(context),
      helpText: start ? l10n.startDate : l10n.expirationDate,
    );
    if (picked == null) return;
    setState(() {
      if (start) {
        _start = picked;
        if (_offsetYears != null) {
          _expiration = addCalendarYears(picked, _offsetYears!);
        }
      } else {
        _expiration = picked;
      }
    });
  }

  Future<void> _save() async {
    final people = ref.read(titulairesProvider).value ?? const <Titulaire>[];
    final titulaireId = _titulaireId ?? (people.isEmpty ? null : people.first.id);
    if (titulaireId == null || _expiration == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).chooseHolderAndDate)),
      );
      return;
    }
    final label = _label.text.trim().isEmpty
        ? localizedKind(AppLocalizations.of(context), _kind)
        : _label.text.trim();
    await ref.read(documentsProvider.notifier).save(
          PapierDocument(
            id: widget.document?.id ?? 0,
            titulaireId: titulaireId,
            kind: _kind,
            label: label,
            expiration: _expiration!,
            notes: _notes.text.trim(),
            remindDays: _remindDays,
          ),
        );
    if (mounted) Navigator.of(context).pop(true);
  }

  Future<void> _confirmDelete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteConfirmTitle),
        content: Text(
          AppLocalizations.of(context).deleteDocumentBody(widget.document!.label),
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
    if (ok != true || !mounted) return;
    await ref.read(documentsProvider.notifier).remove(widget.document!.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final people = ref.watch(titulairesProvider).value ?? const <Titulaire>[];
    final formatter =
        DateFormat.yMMMMd(Localizations.localeOf(context).toString());
    final selectedTitulaire = _titulaireId ??
        (people.isEmpty ? null : people.first.id);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.document == null ? l10n.addPaper : l10n.edit),
        actions: [
          if (widget.document != null)
            IconButton(
              tooltip: l10n.deleteTooltip,
              onPressed: _confirmDelete,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          SectionTitle(l10n.documentType),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final preset in presetsFrance)
                      ChoiceChip(
                        avatar: Icon(iconOf(preset.kind), size: 18),
                        label: Text(localizedKind(l10n, preset.kind)),
                        selected: _kind == preset.kind,
                        onSelected: (_) {
                          setState(() {
                            _kind = preset.kind;
                            if (widget.document == null) {
                              _label.text = localizedKind(l10n, preset.kind);
                            }
                            _computeFromStart = false;
                            _offsetYears = preset.yearOffsets.isEmpty
                                ? null
                                : preset.yearOffsets.first.years;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    localizedHint(l10n, _kind),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionTitle(l10n.details),
          SurfaceCard(
            child: Column(
              children: [
                TextField(
                  controller: _label,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.labelField),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  // ignore: deprecated_member_use
                  value: selectedTitulaire,
                  decoration: InputDecoration(labelText: l10n.holder),
                  items: [
                    for (final person in people)
                      DropdownMenuItem(
                        value: person.id,
                        child: Text(person.prenom),
                      ),
                  ],
                  onChanged: (value) => setState(() => _titulaireId = value),
                ),
                if (_preset.canComputeFromStart) ...[
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.computeFromStart),
                    value: _computeFromStart,
                    onChanged: (value) =>
                        setState(() => _computeFromStart = value),
                  ),
                  if (_computeFromStart) ...[
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final offset in _preset.yearOffsets)
                          ChoiceChip(
                            label: Text(localizedOffset(l10n, offset.years)),
                            selected: _offsetYears == offset.years,
                            onSelected: (_) {
                              setState(() {
                                _offsetYears = offset.years;
                                if (_start != null) {
                                  _expiration =
                                      addCalendarYears(_start!, offset.years);
                                }
                              });
                            },
                          ),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.event_outlined, color: scheme.primary),
                      title: Text(l10n.startDate),
                      subtitle: Text(
                        _start == null ? l10n.choose : formatter.format(_start!),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _pickDate(start: true),
                    ),
                  ],
                ],
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.event, color: scheme.primary),
                  title: Text(l10n.expirationDate),
                  subtitle: Text(
                    _expiration == null
                        ? l10n.choose
                        : formatter.format(_expiration!),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _pickDate(start: false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionTitle(l10n.alertsAndReminders),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.reminderHint,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final day in const [90, 30, 7, 1])
                      FilterChip(
                        label: Text('J-$day'),
                        selected: _remindDays.contains(day),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _remindDays = [..._remindDays, day]
                                ..sort((a, b) => b.compareTo(a));
                            } else {
                              _remindDays =
                                  _remindDays.where((e) => e != day).toList();
                            }
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionTitle(l10n.notes),
          SurfaceCard(
            child: TextField(
              controller: _notes,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: l10n.notesHint,
                alignLabelWithHint: true,
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _save,
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
