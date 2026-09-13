import 'package:flutter/material.dart';

import '../../domain/models.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/format.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final EcheanceStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (bg, fg) = switch (status) {
      EcheanceStatus.ok => (scheme.secondaryContainer, scheme.onSecondaryContainer),
      EcheanceStatus.bientot => (scheme.tertiaryContainer, scheme.onTertiaryContainer),
      EcheanceStatus.depasse => (scheme.errorContainer, scheme.onErrorContainer),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        localizedStatus(AppLocalizations.of(context), status),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
