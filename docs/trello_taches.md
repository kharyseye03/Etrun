# Tableau Trello — e_trun (V1 Member, UI d'abord)

## Colonnes du tableau
`Backlog` · `À faire (sprint)` · `En cours` · `En revue` · `Terminé`

## Étiquettes
- 🟣 Socle   - 🔵 UI / Écran   - 🟢 Animation   - 🟠 API (plus tard)   - 🔴 Bloqué serveur

> Astuce : dans Trello, colle plusieurs lignes d'un coup dans « Ajouter une carte » :
> Trello propose de créer une carte par ligne.

---

## Phase 0 — Socle (🟣)
- Initialiser la structure de dossiers (config, core, service, shared, features)
- Ajouter les dépendances (riverpod, go_router, google_fonts, flutter_animate, animations, intl)
- Définir les couleurs (AppColors) et les surfaces sombres
- Définir la typographie (AppTextStyles) et les espacements (AppDimens)
- Créer le ThemeData sombre (AppTheme)
- Mettre en place le routeur (go_router) et les RoutePaths
- Créer le shell avec la barre du bas à 5 onglets
- Composants partagés : bouton, champ de texte, carte, badge
- Composants partagés : EmptyState, Loader/skeleton, ErrorView
- Créer les données factices (fake repositories)

## Phase 1 — Accès (🔵)
- Splash animé
- Écran Bienvenue (Créer un compte / Se connecter)
- Écran Connexion
- Écran Inscription
- Écran Mot de passe oublié
- Écran Trouver ma salle (recherche nom / ville)
- Écran Mes enseignes + changement d'enseigne

## Phase 2 — Accueil & carte (🔵)
- Écran Accueil (salle, état abonnement, prochain cours, bouton Ma carte)
- Accueil : état « pas d'abonnement » (bouton Choisir une offre)
- Accueil : état « abonnement expiré » (bouton Renouveler)
- Écran Ma carte (QR + expiration + luminosité max)
- Ma carte : état « abonnement non valide » (raison affichée)

## Phase 3 — Cours collectifs (🔵)
- Écran Planning (sélecteur de jour + liste des cours)
- Écran Détail du cours (Réserver / Liste d'attente)
- Écran Mes réservations (à venir / passées, Annuler)
- États vides : aucun cours, aucune réservation

## Phase 4 — Entraînement & objectifs (🔵)
- Écran Mes programmes
- Écran Séance en cours (exercices, charges, répétitions, Terminer)
- Écran Historique des séances
- Écran Mon coach
- Écran Mes objectifs (création + avancement)
- Écran Mesures (saisie + graphique d'évolution)

## Phase 5 — Achat & compte (🔵)
- Écran Les offres
- Écran Récapitulatif
- Écran Paiement (maquette)
- Écran Confirmation (animation de succès)
- Écran Mon compte (profil, photo, mot de passe)
- Écran Mon abonnement + historique d'achats
- Quitter une enseigne / Se déconnecter

## Phase 6 — Finitions animation (🟢)
- Transitions entre écrans (shared axis / fade through)
- Hero : carte de cours → détail
- Apparitions en cascade des listes
- Anneaux de progression animés (objectifs, abonnement)
- Retours haptiques sur les actions clés
- Passe de cohérence visuelle + démo équipe

## Plus tard — Branchement API (🟠)
- Client HTTP + intercepteur (jeton compte + jeton enseigne)
- Stockage sécurisé des jetons
- Remplacer les fake repositories par les vrais
- Cache hors ligne (carte d'accès + réservations)
- Fuseau horaire de la salle

## Bloqué côté serveur (🔴)
- Annuaire public « Trouver ma salle »
- Offres et devis accessibles au client
- Achat d'abonnement + paiement en ligne
- Liste personnelle « Mes réservations »
- Notifications push (FCM / APNs)
