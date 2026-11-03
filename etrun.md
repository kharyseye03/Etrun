Guide pour le développeur mobile (Flutter). Première version : *uniquement le client d'une salle de sport* (profil Member).
Les profils coach, accueil et gérant viendront plus tard.

## L'idée en une phrase

Le client télécharge l'app, crée son compte, choisit une salle, *achète son abonnement depuis l'app*, puis vit tout son
parcours sur son téléphone : entrer à la salle avec un QR, réserver ses cours, suivre ses entraînements et ses objectifs.

## Trois notions à connaître

- *Enseigne* : une marque de salles (ex. « FitClub »). Une enseigne a *plusieurs salles* (adresses).
- *Compte client* : un seul compte pour toutes les enseignes. Le client peut s'inscrire dans plusieurs enseignes.
- *Abonnement* : ce que le client achète dans une enseigne. Il donne accès à une ou plusieurs salles, pendant une durée.

## Le parcours, étape par étape

### 1. Premier lancement
- Écran d'accueil avec deux boutons : *Créer un compte* / *Se connecter*.
- Création : nom, prénom, e-mail, téléphone, mot de passe.
- Lien *Mot de passe oublié* sur l'écran de connexion.
- Après connexion, l'utilisateur reste connecté (pas de reconnexion à chaque ouverture).

### 2. Choisir son enseigne
- Si le client n'a encore aucune enseigne : écran *Trouver ma salle* (recherche par nom ou ville), puis *Rejoindre*.
- S'il en a déjà une : on l'ouvre directement. S'il en a plusieurs : liste *Mes enseignes*, il en choisit une.
- On peut changer d'enseigne à tout moment depuis le menu.

### 3. Acheter son abonnement
- Écran *Les offres* : liste des formules de l'enseigne (nom, durée, prix, salles incluses).
- Le client choisit une formule, puis la salle principale si la formule le demande.
- Écran *Récapitulatif* : formule, salle(s), date de début, date de fin, prix final (remises comprises).
- Bouton *Payer* → paiement par carte → écran *Confirmation*.
- Tant que le client n'a pas d'abonnement actif, l'accueil lui affiche un bouton *Choisir une offre*.

### 4. Accueil (une fois abonné)
- Nom de la salle choisie.
- État de l'abonnement : actif, expire le …, ou expiré (avec bouton *Renouveler*).
- Prochain cours réservé.
- Gros bouton *Ma carte* pour entrer à la salle.

### 5. Entrer à la salle — Ma carte
- Affiche un *QR code* personnel, à présenter à l'accueil ou à la borne.
- Le QR est fourni par le serveur (image + date d'expiration) : ne jamais le générer dans l'app, et le redemander
  avant l'heure refreshAfter qu'il indique.
- Si l'abonnement n'est pas valide, afficher clairement pourquoi (expiré, suspendu…) au lieu du QR.

### 6. Les cours collectifs
- Écran *Planning* : cours de la salle par jour (type, heure, durée, studio, coach, places restantes).
- Un cours ouvre une fiche détail avec le bouton *Réserver*.
- Cours complet : bouton *Liste d'attente*.
- Écran *Mes réservations* : à venir (avec *Annuler*) et passées.
- Les règles (places, délais d'annulation, liste d'attente) sont gérées par le serveur : l'app affiche simplement le message
  qu'il renvoie.

### 7. Mon entraînement
- *Mes programmes* : les programmes donnés par le coach ou la salle.
- Démarrer une séance → voir les exercices → saisir ses charges/répétitions → *Terminer*.
- *Historique* de ses séances.
- *Mon coach* : voir et choisir son coach personnel.

### 8. Mes objectifs
- Créer un objectif (perte de poids, force…), suivre son avancement.
- Saisir ses mesures (poids, tour de taille…) et voir leur évolution.
- Les objectifs suivent le client même s'il change d'enseigne.

### 9. Mon compte
- Modifier son profil et sa photo, changer son mot de passe.
- Voir son abonnement et son historique d'achats.
- *Quitter une enseigne, **Se déconnecter*.

## Les écrans de la V1

| # | Écran | Contenu |
|---|---|---|
| 1 | Bienvenue / Connexion / Inscription | Création de compte, connexion, mot de passe oublié |
| 2 | Trouver ma salle / Mes enseignes | Rejoindre et choisir une enseigne |
| 3 | Les offres → Récapitulatif → Paiement → Confirmation | Achat de l'abonnement |
| 4 | Accueil | Salle, état de l'abonnement, prochain cours, accès à la carte |
| 5 | Ma carte | QR d'entrée |
| 6 | Planning / Détail du cours / Mes réservations | Réserver, annuler, liste d'attente |
| 7 | Mon entraînement | Programmes, séance en cours, historique, coach |
| 8 | Mes objectifs | Objectifs et mesures |
| 9 | Mon compte | Profil, abonnement, enseignes, déconnexion |

Navigation conseillée : barre du bas avec *Accueil · Planning · Ma carte · Entraînement · Compte*.

## Règles pour le développeur

- *Le serveur décide, l'app affiche.* Aucune règle métier dans l'app (prix, places, droits d'accès, délais) : afficher
  les messages d'erreur renvoyés par l'API.
- *Deux jetons de connexion* : un jeton « compte » (toujours valable, renouvelable) et un jeton « enseigne » obtenu en
  choisissant une enseigne (valable 60 min, à redemander quand il expire). Les stocker de façon sécurisée.
- *Heures* : toujours afficher les horaires dans le fuseau de la salle, pas celui du téléphone.
- *États vides* : prévoir un écran clair pour « pas d'enseigne », « pas d'abonnement », « aucun cours », « aucun programme ».
- *Hors connexion* : garder au minimum la dernière carte d'accès et les réservations visibles.

## Ce qui existe déjà côté serveur (et ce qui manque)

API REST sous /api/v1, documentation OpenAPI disponible sur le serveur de dev.

| Étape | Statut | Routes |
|---|---|---|
| Inscription / connexion | ✅ Prêt | POST /users/self-register-global, POST /token/global, POST /token/refresh, POST /users/forgot-password |
| Mes enseignes, rejoindre, choisir, quitter | ✅ Prêt | GET /users/gyms, POST /users/gyms/{tenantId}/join, .../select, .../leave |
| Trouver une salle (annuaire public) | ❌ À construire | — |
| Voir les offres et le prix | ⚠️ Existe, réservé au personnel | GET /membership/membershipType/..., GET /membership/membershipType/{id}/quote |
| Acheter son abonnement + paiement en ligne | ❌ À construire | aujourd'hui seul le personnel vend en salle |
| Abonnement actif | ✅ Prêt | GET /membership/member/{memberId}/active-membership |
| Ma carte (QR) | ✅ Prêt | GET /gym/attendance/me/access-qr |
| Planning et réservations | ✅ Prêt | GET /classes?..., GET /classes/{id}, POST /classes/bookings, DELETE /classes/bookings/{id} |
| Mes réservations (liste personnelle) | ❌ À construire | — |
| Programmes, séances, performances | ✅ Prêt | /programs-assignment, /workouts-logs, /performances |
| Mon coach | ✅ Prêt | GET / PUT /membership/member/me/coach |
| Objectifs et mesures | ✅ Prêt | /fitness-tracker/members/{memberId}/goals, .../measurements |
| Notifications push (FCM/APNs) | ❌ À construire | — |

## Ordre de réalisation conseillé

1. Connexion, inscription, choix de l'enseigne.
2. Accueil + Ma carte (QR) — le client peut déjà entrer à la salle.
3. Planning et réservations.
4. Entraînement et objectifs.
5. Achat de l'abonnement dans l'app — dès que le serveur expose l'achat et le paiement.
6. Notifications push.