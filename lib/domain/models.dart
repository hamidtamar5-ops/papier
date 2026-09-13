enum DocumentKind {
  cni,
  passeport,
  permis,
  carteVitale,
  carteGrise,
  controleTechnique,
  assuranceAuto,
  personnalise,
}

enum EcheanceStatus { ok, bientot, depasse }

enum ThemePreference { system, light, dark }

enum AppLanguage { system, fr, en, es, de, ar }

class Titulaire {
  const Titulaire({
    required this.id,
    required this.prenom,
    required this.colorValue,
  });

  final int id;
  final String prenom;
  final int colorValue;

  Titulaire copyWith({int? id, String? prenom, int? colorValue}) {
    return Titulaire(
      id: id ?? this.id,
      prenom: prenom ?? this.prenom,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  Map<String, Object?> toJson() => {
        'id': id,
        'prenom': prenom,
        'colorValue': colorValue,
      };

  factory Titulaire.fromJson(Map<String, Object?> json) {
    return Titulaire(
      id: json['id']! as int,
      prenom: json['prenom']! as String,
      colorValue: json['colorValue']! as int,
    );
  }
}

class PapierDocument {
  const PapierDocument({
    required this.id,
    required this.titulaireId,
    required this.kind,
    required this.label,
    required this.expiration,
    this.notes = '',
    this.remindDays = const [90, 30, 7],
    this.archived = false,
  });

  final int id;
  final int titulaireId;
  final DocumentKind kind;
  final String label;
  final DateTime expiration;
  final String notes;
  final List<int> remindDays;
  final bool archived;

  PapierDocument copyWith({
    int? id,
    int? titulaireId,
    DocumentKind? kind,
    String? label,
    DateTime? expiration,
    String? notes,
    List<int>? remindDays,
    bool? archived,
  }) {
    return PapierDocument(
      id: id ?? this.id,
      titulaireId: titulaireId ?? this.titulaireId,
      kind: kind ?? this.kind,
      label: label ?? this.label,
      expiration: expiration ?? this.expiration,
      notes: notes ?? this.notes,
      remindDays: remindDays ?? this.remindDays,
      archived: archived ?? this.archived,
    );
  }

  Map<String, Object?> toJson() => {
        'id': id,
        'titulaireId': titulaireId,
        'kind': kind.name,
        'label': label,
        'expirationMs': expiration.millisecondsSinceEpoch,
        'notes': notes,
        'remindDays': remindDays,
        'archived': archived,
      };

  factory PapierDocument.fromJson(Map<String, Object?> json) {
    return PapierDocument(
      id: json['id']! as int,
      titulaireId: json['titulaireId']! as int,
      kind: DocumentKind.values.byName(json['kind']! as String),
      label: json['label']! as String,
      expiration: DateTime.fromMillisecondsSinceEpoch(
        json['expirationMs']! as int,
      ),
      notes: (json['notes'] as String?) ?? '',
      remindDays: ((json['remindDays'] as List<dynamic>?) ?? const [90, 30, 7])
          .map((e) => e as int)
          .toList(),
      archived: (json['archived'] as bool?) ?? false,
    );
  }
}

class AppSettings {
  const AppSettings({
    this.theme = ThemePreference.system,
    this.defaultRemindDays = const [90, 30, 7],
    this.notificationsEnabled = true,
    this.language = AppLanguage.system,
  });

  final ThemePreference theme;
  final List<int> defaultRemindDays;
  final bool notificationsEnabled;
  final AppLanguage language;

  AppSettings copyWith({
    ThemePreference? theme,
    List<int>? defaultRemindDays,
    bool? notificationsEnabled,
    AppLanguage? language,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      defaultRemindDays: defaultRemindDays ?? this.defaultRemindDays,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
    );
  }
}

/// v1 : tout est débloqué. Mettre à true plus tard pour l’IAP foyer / PDF.
const kIapEnabled = false;
