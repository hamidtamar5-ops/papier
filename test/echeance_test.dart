import 'package:flutter_test/flutter_test.dart';
import 'package:papier/domain/echeance.dart';
import 'package:papier/domain/models.dart';
import 'package:papier/domain/presets.dart';

void main() {
  final now = DateTime(2026, 9, 5);

  test('statut OK au-delà de la fenêtre', () {
    expect(statusOf(DateTime(2027, 1, 1), now), EcheanceStatus.ok);
  });

  test('statut bientôt dans la fenêtre 90 jours', () {
    expect(statusOf(DateTime(2026, 10, 1), now), EcheanceStatus.bientot);
  });

  test('statut dépassé', () {
    expect(statusOf(DateTime(2026, 9, 1), now), EcheanceStatus.depasse);
  });

  test('CT +2 ans depuis le dernier contrôle', () {
    expect(
      addCalendarYears(DateTime(2026, 3, 15), 2),
      DateTime(2028, 3, 15),
    );
  });

  test('CT +4 ans véhicule neuf', () {
    expect(
      addCalendarYears(DateTime(2026, 2, 28), 4),
      DateTime(2030, 2, 28),
    );
  });

  test('fenêtre bientôt = plus grand délai de rappel', () {
    expect(soonWindow(const [30, 90, 7]), 90);
  });

  test('libellé jours', () {
    expect(daysLabel(0), 'expire aujourd’hui');
    expect(daysLabel(1), 'dans 1 jour');
    expect(daysLabel(-2), 'expiré depuis 2 jours');
  });

  PapierDocument doc(String label, DateTime expiration) {
    return PapierDocument(
      id: 1,
      titulaireId: 1,
      kind: DocumentKind.cni,
      label: label,
      expiration: expiration,
    );
  }

  test('digest alerte un papier dépassé', () {
    final digest = alertDigest(
      [doc('Carte d’identité', DateTime(2026, 8, 1))],
      now,
    );
    expect(digest.hasAlerts, isTrue);
    expect(digest.expiredCount, 1);
    expect(digest.title, 'Papiers à renouveler');
    expect(digest.body, 'Carte d’identité est dépassé.');
  });

  test('digest alerte le jour J', () {
    final digest = alertDigest(
      [doc('Passeport', DateTime(2026, 9, 5))],
      now,
    );
    expect(digest.todayCount, 1);
    expect(digest.title, 'Échéance aujourd’hui');
    expect(digest.body, 'Passeport expire aujourd’hui.');
  });

  test('digest ignore les échéances lointaines', () {
    final digest = alertDigest(
      [doc('Permis', DateTime(2027, 1, 1))],
      now,
    );
    expect(digest.hasAlerts, isFalse);
  });
}
