import 'models.dart';

class DocumentPreset {
  const DocumentPreset({
    required this.kind,
    required this.label,
    required this.hint,
    this.canComputeFromStart = false,
    this.yearOffsets = const [],
  });

  final DocumentKind kind;
  final String label;
  final String hint;
  final bool canComputeFromStart;
  final List<YearOffset> yearOffsets;
}

class YearOffset {
  const YearOffset({required this.years, required this.label});

  final int years;
  final String label;
}

const presetsFrance = <DocumentPreset>[
  DocumentPreset(
    kind: DocumentKind.cni,
    label: 'Carte d’identité',
    hint:
        'Saisissez la date d’expiration écrite sur la carte. Durée habituelle : 10 ans après délivrance — vérifiez toujours la carte.',
  ),
  DocumentPreset(
    kind: DocumentKind.passeport,
    label: 'Passeport',
    hint:
        'Date d’expiration sur le passeport. Souvent 10 ans (majeur) ou 5 ans (mineur).',
  ),
  DocumentPreset(
    kind: DocumentKind.permis,
    label: 'Permis de conduire',
    hint: 'Saisissez la date figurant sur le titre. Aucune durée n’est inventée.',
  ),
  DocumentPreset(
    kind: DocumentKind.carteVitale,
    label: 'Carte vitale',
    hint: 'Saisissez la date que vous souhaitez surveiller, si elle est connue.',
  ),
  DocumentPreset(
    kind: DocumentKind.carteGrise,
    label: 'Carte grise',
    hint: 'Saisissez la date à surveiller (pas un scan du certificat).',
  ),
  DocumentPreset(
    kind: DocumentKind.controleTechnique,
    label: 'Contrôle technique',
    hint: 'Date de validité, ou calcul depuis le dernier contrôle (+2 ans, ou +4 ans si véhicule neuf).',
    canComputeFromStart: true,
    yearOffsets: [
      YearOffset(years: 2, label: '+ 2 ans (déjà en circulation)'),
      YearOffset(years: 4, label: '+ 4 ans (véhicule neuf)'),
    ],
  ),
  DocumentPreset(
    kind: DocumentKind.assuranceAuto,
    label: 'Assurance auto',
    hint: 'Date d’échéance, ou + 1 an depuis le début du contrat.',
    canComputeFromStart: true,
    yearOffsets: [
      YearOffset(years: 1, label: '+ 1 an'),
    ],
  ),
  DocumentPreset(
    kind: DocumentKind.personnalise,
    label: 'Autre papier',
    hint: 'Libellé libre et date. Pas de photo, pas de numéro de pièce.',
  ),
];

DocumentPreset presetOf(DocumentKind kind) {
  return presetsFrance.firstWhere((p) => p.kind == kind);
}

DateTime addCalendarYears(DateTime start, int years) {
  final day = start.day;
  final candidate = DateTime(start.year + years, start.month, day);
  if (candidate.month == start.month) return candidate;
  return DateTime(start.year + years, start.month + 1, 0);
}

const titulaireColors = <int>[
  0xFF2C6E6A,
  0xFF3D5A80,
  0xFF8C4A2F,
  0xFF5C4D7A,
  0xFF3E6B2E,
  0xFF7A4E6A,
];
