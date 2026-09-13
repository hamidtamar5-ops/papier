import 'package:flutter/material.dart';

import '../../domain/echeance.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/format.dart';

class AlertBanner extends StatelessWidget {
  const AlertBanner({super.key, required this.digest});

  final AlertDigest digest;

  @override
  Widget build(BuildContext context) {
    if (!digest.hasAlerts) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final urgent = digest.expiredCount > 0 || digest.todayCount > 0;
    final bg = urgent ? scheme.errorContainer : scheme.tertiaryContainer;
    final fg = urgent ? scheme.onErrorContainer : scheme.onTertiaryContainer;
    final icon = digest.expiredCount > 0
        ? Icons.error_outline
        : digest.todayCount > 0
            ? Icons.notification_important_outlined
            : Icons.schedule_outlined;

    return Card(
      color: bg,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: fg),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizedDigestTitle(l10n, digest),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: fg,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    localizedDigestBody(l10n, digest),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: fg,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
