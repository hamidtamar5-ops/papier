import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/echeance.dart';
import '../../domain/models.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/format.dart';
import '../kind_style.dart';
import 'status_chip.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({
    super.key,
    required this.document,
    required this.status,
    required this.titulaire,
    required this.now,
    required this.onOpen,
    required this.onDelete,
  });

  final PapierDocument document;
  final EcheanceStatus status;
  final Titulaire? titulaire;
  final DateTime now;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final formatter = DateFormat.yMMMMd(Localizations.localeOf(context).toString());
    final accent = switch (status) {
      EcheanceStatus.ok => scheme.primary,
      EcheanceStatus.bientot => scheme.tertiary,
      EcheanceStatus.depasse => scheme.error,
    };
    final days = daysUntil(document.expiration, now);
    final personColor = Color(titulaire?.colorValue ?? 0xFF2C6E6A);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onOpen,
          onLongPress: onDelete,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: accent),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: personColor.withValues(alpha: 0.16),
                          foregroundColor: personColor,
                          child: Icon(iconOf(document.kind), size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                document.label,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${titulaire?.prenom ?? '—'} · ${formatter.format(document.expiration)}',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                localizedDaysLabel(l10n, days),
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                  color: accent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        StatusChip(status: status),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
