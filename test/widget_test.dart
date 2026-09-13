import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:papier/domain/models.dart';
import 'package:papier/l10n/app_localizations.dart';
import 'package:papier/ui/home_page.dart';
import 'package:papier/ui/theme.dart';

Widget _app(Widget home) {
  return MaterialApp(
    theme: buildTheme(Brightness.light),
    locale: const Locale('fr'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: home,
  );
}

void main() {
  const moi = Titulaire(id: 1, prenom: 'Moi', colorValue: 0xFF2C6E6A);

  testWidgets('accueil vide propose d’ajouter un papier', (tester) async {
    await tester.pumpWidget(
      _app(
        HomeView(
          documents: const [],
          titulaires: const [moi],
          soonDays: 90,
          onAdd: () {},
          onOpenSettings: () {},
          onOpen: (_) {},
          onDelete: (_) {},
          now: DateTime(2026, 9, 5),
        ),
      ),
    );

    expect(find.text('Aucun papier pour l’instant'), findsOneWidget);
    expect(find.text('Ajouter un papier'), findsWidgets);
  });

  testWidgets('accueil affiche une échéance bientôt', (tester) async {
    final doc = PapierDocument(
      id: 1,
      titulaireId: 1,
      kind: DocumentKind.controleTechnique,
      label: 'Contrôle technique',
      expiration: DateTime(2026, 9, 25),
    );

    await tester.pumpWidget(
      _app(
        HomeView(
          documents: [doc],
          titulaires: const [moi],
          soonDays: 90,
          onAdd: () {},
          onOpenSettings: () {},
          onOpen: (_) {},
          onDelete: (_) {},
          now: DateTime(2026, 9, 5),
        ),
      ),
    );

    expect(find.text('Contrôle technique'), findsWidgets);
    expect(find.text('Bientôt'), findsWidgets);
    expect(find.text('dans 20 jours'), findsWidgets);
  });
}
