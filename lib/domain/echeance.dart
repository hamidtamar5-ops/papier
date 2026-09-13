import 'models.dart';

DateTime dateOnly(DateTime value) => DateTime(value.year, value.month, value.day);

int daysUntil(DateTime expiration, DateTime now) {
  return dateOnly(expiration).difference(dateOnly(now)).inDays;
}

EcheanceStatus statusOf(
  DateTime expiration,
  DateTime now, {
  int soonDays = 90,
}) {
  final days = daysUntil(expiration, now);
  if (days < 0) return EcheanceStatus.depasse;
  if (days <= soonDays) return EcheanceStatus.bientot;
  return EcheanceStatus.ok;
}

String statusLabel(EcheanceStatus status) {
  switch (status) {
    case EcheanceStatus.ok:
      return 'OK';
    case EcheanceStatus.bientot:
      return 'Bientôt';
    case EcheanceStatus.depasse:
      return 'Dépassé';
  }
}

String daysLabel(int days) {
  if (days < 0) {
    final n = -days;
    return n == 1 ? 'expiré hier' : 'expiré depuis $n jours';
  }
  if (days == 0) return 'expire aujourd’hui';
  if (days == 1) return 'dans 1 jour';
  return 'dans $days jours';
}

int soonWindow(List<int> remindDays) {
  if (remindDays.isEmpty) return 90;
  return remindDays.reduce((a, b) => a > b ? a : b);
}

/// Alertes urgentes : dépassé, jour J, ou dans les 7 prochains jours.
class AlertDigest {
  const AlertDigest({
    required this.expiredCount,
    required this.todayCount,
    required this.soonCount,
    this.sampleLabel,
  });

  final int expiredCount;
  final int todayCount;
  final int soonCount;
  final String? sampleLabel;

  bool get hasAlerts => expiredCount + todayCount + soonCount > 0;

  String get title {
    if (expiredCount > 0) return 'Papiers à renouveler';
    if (todayCount > 0) return 'Échéance aujourd’hui';
    return 'Échéance proche';
  }

  String get body {
    if (expiredCount == 1 && todayCount == 0 && soonCount == 0) {
      return '${sampleLabel ?? 'Un papier'} est dépassé.';
    }
    if (todayCount == 1 && expiredCount == 0 && soonCount == 0) {
      return '${sampleLabel ?? 'Un papier'} expire aujourd’hui.';
    }
    if (soonCount == 1 && expiredCount == 0 && todayCount == 0) {
      return '${sampleLabel ?? 'Un papier'} expire dans moins de 7 jours.';
    }
    final parts = <String>[];
    if (expiredCount > 0) {
      parts.add(
        expiredCount == 1 ? '1 papier dépassé' : '$expiredCount papiers dépassés',
      );
    }
    if (todayCount > 0) {
      parts.add(todayCount == 1 ? '1 aujourd’hui' : '$todayCount aujourd’hui');
    }
    if (soonCount > 0) {
      parts.add(
        soonCount == 1
            ? '1 dans moins de 7 jours'
            : '$soonCount dans moins de 7 jours',
      );
    }
    return '${parts.join(' · ')}.';
  }
}

AlertDigest alertDigest(List<PapierDocument> documents, DateTime now) {
  var expired = 0;
  var today = 0;
  var soon = 0;
  String? sample;
  for (final document in documents) {
    if (document.archived) continue;
    final days = daysUntil(document.expiration, now);
    if (days < 0) {
      expired += 1;
      sample ??= document.label;
    } else if (days == 0) {
      today += 1;
      sample ??= document.label;
    } else if (days <= 7) {
      soon += 1;
      sample ??= document.label;
    }
  }
  return AlertDigest(
    expiredCount: expired,
    todayCount: today,
    soonCount: soon,
    sampleLabel: sample,
  );
}
