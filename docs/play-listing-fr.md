# Fiche Play — Échéances — fr-FR

## Mots-clés
- Primaire : date d'expiration
- Secondaires : rappel expiration, papiers, contrôle technique
- Longue traîne : date d'expiration carte d'identité, rappel passeport, échéance assurance

## Titre (29/30)

```
Échéances: dates d'expiration
```

## Description courte (79/80)

```
Rappels avant l'expiration de CNI, passeport, CT et assurance. Données locales.
```

## Description longue (1184/4000)

```
Ne ratez plus une date d'expiration. Échéances enregistre les dates de vos papiers (carte d'identité, passeport, permis, contrôle technique, assurance) et vous envoie un rappel, sur cet appareil.

Une CNI ou un passeport oublié, un contrôle technique dépassé : ces dates d'expiration se gèrent mal dans un agenda générique. L'app s'adresse aux foyers qui veulent un suivi simple, sans photo de pièce.

Ajoutez un papier en quelques secondes : type, titulaire, date. Les rappels partent le matin (J-90, J-30, J-7, J-1) et le jour J. Un bandeau signale ce qui est dépassé ou proche. Un widget Android affiche la prochaine échéance.

Plusieurs personnes du foyer peuvent avoir leurs propres papiers, chacune avec une couleur. L'interface est disponible en français, anglais, espagnol, allemand et arabe.

Les dates restent locales. Pas de compte, pas de scan, pas de numéro de document. Vous pouvez exporter ou importer un fichier JSON pour changer de téléphone. Échéances n'est pas un service administratif : elle n'établit aucun titre et ne remplace pas une démarche officielle.

Des publicités AdMob peuvent s'afficher. Dans l'Espace économique européen, le consentement est demandé.
```

## Contrôle politique
- [x] Pas de stuffing / CTA / classements / promo / émojis interdits
- [x] Pas de « gratuit » / « sans pub » / « n°1 »
- [x] Fonctionnalités réelles uniquement (pas d'export PDF)

## Brief assets
- Icône : 512×512, document + calendrier + horloge, fond teal, déjà dans `assets/icon.png` (exporter PNG Play si besoin)
- Feature graphic 1024×500 : prochaine échéance au centre, fond teal #0B4F4F, peu de texte (« Dates de papiers »), pas de copie de l'icône sur le bord
- Captures (ordre 1→8), téléphone 1080×1920 :
  1. Accueil avec prochaine échéance et bandeau alerte
  2. Liste À renouveler / À surveiller / À jour
  3. Formulaire d'ajout (types CNI, passeport, CT)
  4. Réglages rappels + titulaires
  5. État vide (premier lancement)
- Alt text : `Accueil Échéances avec la prochaine date d'expiration et son statut.`

## Catégorie et tags
- Catégorie : Productivité
- Tags possibles : organisation, vie quotidienne
- Politique de confidentialité : https://hamidtamar5-ops.github.io/papier/privacy.html

## Tests A/B proposés
1. Description courte : « Rappels avant l'expiration… » vs « Suivez CNI, passeport et CT : alertes le matin, données sur l'appareil. »
2. Capture 1 : UI seule vs UI + une ligne « Prochaine date de papier »
3. Icône actuelle vs variante calendrier seul
