# 5. Exigences fonctionnelles

Priorisation MoSCoW : **M** (Must — indispensable Phase 1), **S** (Should — important, Phase 1 si
possible), **C** (Could — souhaitable, phases suivantes), **W** (Won't — écarté pour l'instant).
Chaque exigence renvoie aux parcours (P-xx) et règles métier (RM-xx) concernés.

## 5.1 Référentiel archers et clubs

| Id | Exigence | Priorité | Liens |
|---|---|---|---|
| EF-01 | Gérer les archers : identité, n° de licence, club, date de naissance, sexe, arme pratiquée | M | P-02, RM-07 |
| EF-02 | Gérer les clubs (nom, n° d'affiliation, comité) | M | P-02 |
| EF-03 | Calculer automatiquement la catégorie d'âge à partir de la date de naissance et de la saison | M | RM-25 |
| EF-04 | Déterminer la catégorie de classement (sexe × âge × arme × discipline) avec les regroupements réglementaires | M | RM-24, RM-26 |
| EF-05 | Prendre en compte un surclassement (annuel ou ponctuel) avec contrôle de validité | S | RM-27 |
| EF-06 | Importer une liste d'archers (fichier CSV/tableur) pour éviter la ressaisie | S | P-02 |

## 5.2 Préparation du concours

| Id | Exigence | Priorité | Liens |
|---|---|---|---|
| EF-10 | Créer un concours : discipline, dates, lieu, club organisateur, arbitres, nombre de cibles | M | P-01, RM-01, RM-07 |
| EF-11 | Définir les départs (horaires, greffe, inspection, entraînement, début des tirs) et les blasons | M | P-01, RM-05 |
| EF-12 | Générer le mandat (document diffusable) à partir des informations du concours | S | P-01, RM-05 |
| EF-13 | Enregistrer les inscriptions par départ, avec contrôle de la licence et de la catégorie | M | P-02, RM-29, RM-30 |
| EF-14 | Gérer une liste d'attente et les désistements | C | P-02 |
| EF-15 | Contrôler les inscriptions U11 (discipline, arme, alerte puissance) | S | RM-28 |

## 5.3 Greffe du jour J

| Id | Exigence | Priorité | Liens |
|---|---|---|---|
| EF-20 | Pointer les présents et le contrôle des licences au greffe | M | P-03, RM-03 |
| EF-21 | Attribuer les cibles avec contrôle bloquant des règles fédérales (max 2 archers/club/cible) et alerte si un départ n'accueille aucun archer extérieur | M | P-03, RM-02, RM-04 |
| EF-22 | Réattribuer les cibles en cas de défection, en préservant les règles | M | P-03, RM-03 |
| EF-23 | Éditer le plan de cibles et les feuilles de marque pré-remplies (impression) | M | P-03, RM-12 |
| EF-24 | Enregistrer les mises (paiement sur place) et l'état de la caisse du greffe | C | P-03 |

## 5.4 Saisie des scores

| Id | Exigence | Priorité | Liens |
|---|---|---|---|
| EF-30 | Saisir les scores par volée et par archer (valeurs 1-10, M) avec tri décroissant automatique | M | P-04, RM-13 |
| EF-31 | Calculer automatiquement les totaux par série et le nombre de 10 et de 9 | M | P-04, RM-17 |
| EF-32 | Enregistrer la validation de fin de tir (archer + marqueur) et verrouiller la feuille | M | P-04, RM-17 |
| EF-33 | Tracer toute correction après verrouillage, avec identification de l'arbitre | M | P-05, RM-20 |
| EF-34 | Signaler une divergence entre feuille papier et saisie électronique et appliquer la règle de primauté | S | P-05, RM-12, RM-18 |
| EF-35 | Gérer les flèches en surnombre et hors séquence (marquage M assisté) | C | RM-16, RM-21 |

## 5.5 Classements et résultats

| Id | Exigence | Priorité | Liens |
|---|---|---|---|
| EF-40 | Calculer les classements par catégorie de classement, hommes et femmes séparés | M | P-06, RM-09, RM-24 |
| EF-41 | Appliquer le départage réglementaire (nb de 10, puis nb de 9, puis ex æquo) | M | P-06, RM-22 |
| EF-42 | Ne retenir que le premier score d'un archer inscrit à plusieurs départs (les autres restant transmis) | M | RM-06 |
| EF-43 | Éditer les résultats conformes (contenu de l'art. B.1.3) en impression/PDF | M | P-06, RM-07 |
| EF-44 | Produire un export générique des résultats (CSV) | M | P-07 |
| EF-45 | Produire le fichier au format attendu par la FFTA (Résult'Arc/IANSEO) | C* | P-07, RM-08, QO-01 |
| EF-46 | Gérer le cas d'une compétition interrompue (classement figé sur les volées complètes) | C | RM-10 |

\* passe en Must dès que le format fédéral est obtenu (voir [QO-01](08-questions-ouvertes.md)).

## 5.6 Transverse

| Id | Exigence | Priorité | Liens |
|---|---|---|---|
| EF-60 | Gérer des comptes utilisateurs avec rôles (administrateur, organisateur, greffe, marqueur, arbitre, consultation) | M | P-09, tous |
| EF-61 | Journaliser les actions sensibles (corrections de scores, modifications d'attribution) | S | RM-20, ENF-03 |
| EF-62 | Publier une vue de consultation des classements (affichage salle / lien public) | S | P-08 |

## 5.7 Administration technique

| Id | Exigence | Priorité | Liens |
|---|---|---|---|
| EF-70 | Exporter la configuration technique de l'application (comptes utilisateurs, paramètres) sous forme chiffrée | S | P-09, ENF-14 |
| EF-71 | Importer une configuration technique exportée pour équiper un nouveau poste du club, sans écraser ni requérir de données de concours existantes | S | P-09, ENF-14 |
