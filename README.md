# Échéances (projet `papier`)

App Flutter Android : rappels de dates pour les papiers officiels français (CNI, passeport, permis, carte vitale, carte grise, contrôle technique, assurance). **Des dates, pas des scans.**

## Lancer

```bash
cd papier
flutter pub get
flutter run
```

## Architecture

- `lib/domain` — modèles, presets FR, calcul de statuts (sans Flutter)
- `lib/data` — SQLite (`sqflite`), JSON local, notifications, widget
- `lib/state` — Riverpod
- `lib/ui` — accueil, formulaire, réglages

Données uniquement dans `papier.db` (documents de l’app). Pas de compte, pas de backend, pas d’analytics, pas de pubs.

## Packages

| Package | Rôle |
|---|---|
| `flutter_riverpod` | État |
| `sqflite` + `path_provider` | Stockage local |
| `flutter_local_notifications` + `timezone` | Rappels J-90 / 30 / 7 |
| `home_widget` | Widget écran d’accueil |
| `share_plus` / `file_picker` | Export / import JSON |
| `permission_handler` | Permission notifications Android 13+ |
| `intl` + `flutter_localizations` | Français |

IAP foyer / PDF : flag `kIapEnabled` dans `lib/domain/models.dart` (désactivé, tout ouvert en v1).

## Permissions Android

| Permission | Pourquoi |
|---|---|
| `POST_NOTIFICATIONS` | Rappels avant échéance (Android 13+) |
| `RECEIVE_BOOT_COMPLETED` | Reprogrammer les rappels après redémarrage (plugin) |

Pas de caméra, pas de localisation, pas d’alarme exacte.

## Widget

Ajouter le widget **Échéances** depuis le lanceur Android. Il affiche la prochaine date. Un tap ouvre l’app.

## Hors scope v1

- Scan / photo / PDF de pièces d’identité
- Compte cloud, Drive, Firebase
- Démarches ANTS / France Identité
- Carnet d’entretien, carburant, quittances
- iOS (code Flutter portable, pas de cible iOS ici)
- Mentions « officiel » ou « conforme à la loi »

## Tests

```bash
flutter test
flutter analyze
```
