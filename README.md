# Etrun

Application mobile Flutter pour les membres de salles de sport : accès par QR code, réservation de cours, suivi des entraînements et des objectifs. Multi-enseignes, design sombre premium.

> **Statut : V1 en construction, partie UI.** Les écrans utilisent des données d'exemple, l'API n'est pas encore branchée.

## Fonctionnalités (V1 — profil Membre)

| Écran | Contenu | État |
|---|---|---|
| Bienvenue / Connexion / Inscription | Création de compte, connexion, mot de passe oublié | ✅ UI |
| Accueil | Salle, état de l'abonnement, prochain cours, statistiques du mois | ✅ UI |
| Ma carte | Pass QR d'entrée, renouvelé automatiquement | ✅ UI |
| Trouver ma salle / Mes enseignes | Rejoindre et choisir une enseigne | ⏳ |
| Planning / Réservations | Réserver, annuler, liste d'attente | ⏳ |
| Entraînement | Programmes, séance en cours, historique, coach | ⏳ |
| Objectifs | Objectifs et mesures | ⏳ |
| Offres / Paiement | Achat de l'abonnement dans l'app | ⏳ |
| Compte | Profil, abonnement, enseignes, déconnexion | ⏳ |

Le cahier des charges complet est dans [etrun.md](etrun.md), la charte graphique dans [charte-graphique-mobile.md](charte-graphique-mobile.md).

## Stack

- **Flutter** 3.41 / Dart 3.11
- **flutter_riverpod** : état et injection
- **go_router** : navigation, barre du bas à 5 onglets (`StatefulShellRoute`)
- **flutter_animate** : animations
- **google_fonts** : Geist et Geist Mono
- **intl** : dates et nombres en français
- **qr_flutter** : QR de démonstration (en production, le QR vient du serveur)

## Organisation du code

```
lib/
├── main.dart
├── core/
│   ├── constants/   # couleurs, typographie, espacements (charte)
│   ├── theme/       # ThemeData sombre
│   └── router/      # routes et RoutePaths
├── shared/
│   ├── layout/      # barre de navigation, écrans génériques
│   └── widgets/     # EtButton, EtCard, StatusBadge, ProgressRing…
└── features/
    └── <feature>/
        ├── data/models/
        └── presentation/
            ├── providers/
            ├── screens/
            └── widgets/
```

Règles :
- **Feature-first** : tout ce qui concerne une fonctionnalité vit dans son dossier.
- **`shared/`** ne contient que ce qui sert à au moins deux features.
- **Le serveur décide, l'app affiche** : aucune règle métier dans l'app.
- Les écrans ne lisent que des **providers**. Pour brancher l'API, seuls les providers changent.

## Lancer le projet

```bash
flutter pub get
flutter run
```

Pour un téléphone Android en débogage sans fil :

```bash
adb connect <ip>:<port>
flutter run -d <ip>:<port>
```

## Design

Thème sombre (OLED), accent vert énergie `#C6FF3D`, orange sprint `#FF6B00` pour l'effort et les comptes à rebours. Pas d'ombres : le volume des cartes est marqué par un filet de 1 pt. Toutes les couleurs sont dans [`lib/core/constants/app_colors.dart`](lib/core/constants/app_colors.dart).
