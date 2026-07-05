# 4. Règles métier FFTA

Synthèse des règles fédérales que l'application doit faire respecter. Chaque règle renvoie à
l'article du Livre des Règlements Sportifs et Arbitrage FFTA (édition juillet 2025) ; les extraits
détaillés et tracés sont conservés dans le dépôt du projet
(specs/organisation-concours-ffta.spec.md, specs/decompte-points-ffta.spec.md,
specs/categories-ffta.spec.md).

**Relecteurs arbitres** : merci de vérifier chaque règle (formulation, article, exceptions oubliées)
et de signaler les règles manquantes pour le périmètre de la Phase 1 (Tir à 18m, qualification).

## 4.1 Organisation et greffe

| Id | Règle | Article |
|---|---|---|
| RM-01 | Un concours sélectif compte au minimum 6 cibles par départ (sauf DOM-TOM) | I.B (préambule) |
| RM-02 | Pas plus de 2 archers d'un même club sur une même cible, quel que soit le rythme de tir ; la participation d'archers licenciés dans un autre club est obligatoire à chaque départ | I.B / B.1.2 |
| RM-03 | Avant le début du concours, le greffe contrôle les licences et vérifie qu'aucune défection ne laisse un archer isolé ou 2 archers du même club sur une cible | B.1.2 |
| RM-04 | Éviter de placer 4 tireurs sur une cible s'il y a un archer en fauteuil roulant | B.1.2 |
| RM-05 | Le mandat comporte : heure d'ouverture du greffe, inspection du matériel, entraînement, début des tirs, forme du concours, blasons utilisés (Tir à 18m) | B.1.1 |
| RM-06 | Si un archer participe à plusieurs départs du même concours, seul le premier score compte pour le classement officiel ; tous les scores sont transmis pour le classement national | B.7 |

## 4.2 Résultats et transmission

| Id | Règle | Article |
|---|---|---|
| RM-07 | Les résultats comportent : date, lieu, club organisateur, nom des arbitres, nombre de participants par catégorie, et pour chaque archer : nom, prénom, n° de licence, club, catégorie, score par distance | B.1.3 |
| RM-08 | Les résultats sont envoyés via l'application préconisée par la FFTA dès la fin de la compétition ; retard > 3 jours : 1 an de suppression d'organisation ; non-envoi : 2 ans | B.1.4 |
| RM-09 | Lors des championnats, le classement se fait par catégories d'âge et d'armes (sauf classement scratch annoncé) | B.1.3 |
| RM-10 | En cas d'interruption de la compétition (force majeure), le classement est validé sur les scores acquis si tous les concurrents ont tiré le même nombre de volées ; la compétition n'est jamais annulée | B.7 |

## 4.3 Marque et scores (Tir à 18m et TAE)

| Id | Règle | Article |
|---|---|---|
| RM-11 | Un marqueur est désigné par cible ; s'il n'y a pas de marqueur fourni, la double marque est obligatoire | B.3 / II.B.6 |
| RM-12 | En cas d'enregistrement électronique des points, les feuilles de marque papier restent les seules valeurs officielles et doivent être conservées | B.3 |
| RM-13 | Les valeurs des flèches sont inscrites en ordre décroissant, annoncées par l'archer et vérifiées par les autres archers de la cible ; désaccord → décision d'arbitre, définitive | II.B.6.1 |
| RM-14 | Une flèche touchant deux zones ou une ligne de séparation prend la valeur la plus haute | II.B.6.2 |
| RM-15 | Flèche sur le mauvais blason ou hors zones marquantes : comptée manquée (M) | II.B.6.2 |
| RM-16 | Blasons multi-spots (18m) : si plusieurs flèches d'un même archer tombent dans la même zone, seule la plus basse compte, les autres sont M | II.2.B.6 |
| RM-17 | La feuille de marque doit comporter la valeur de chaque flèche, les totaux et le nombre de 10 et de 9 (18m), et être signée par l'archer et le marqueur ; feuille non conforme non corrigée → disqualification possible | II.B.6.4 |
| RM-18 | Divergence entre les deux feuilles papier : le total le plus bas fait foi ; divergence papier/électronique : le total électronique fait foi pour le score, le nombre de 10/9 vient du papier | II.B.6.4 |
| RM-19 | Une information manquante sur la feuille est considérée comme inexistante (0) pour le classement | B.7 / II.B.6.4 |
| RM-20 | Une erreur d'enregistrement peut être corrigée par un arbitre tant que les flèches sont en cible et non touchées (correction tracée) | B.7 |
| RM-21 | Flèche tirée hors séquence : la flèche la plus haute de la volée est marquée M ; flèches en surnombre : les flèches en trop sont M | II.B.8 |

## 4.4 Classements et départages

| Id | Règle | Article |
|---|---|---|
| RM-22 | Départage des égalités hors phases finales : 1) plus grand nombre de 10 ; 2) plus grand nombre de 9 (18m) ou de X (TAE) ; 3) ex æquo (tirage au sort pour le seul ordre du tableau) | II.B.6.5 |
| RM-23 | Pour l'accession aux phases finales ou l'attribution de médailles : tir de barrage obligatoire, sans prise en compte du nombre de 10/9 | II.B.6.5 |
| RM-24 | Les classements distinguent les hommes et les femmes, et respectent toutes les catégories d'âge reconnues (championnats départementaux et régionaux) | C.3.1 |

## 4.5 Catégories et licences

| Id | Règle | Article |
|---|---|---|
| RM-25 | Catégories d'âge (âge dans l'année civile de la licence) : U11 ≤ 10 ans ; U13 : 11-12 ; U15 : 13-14 ; U18 : 15-17 ; U21 : 18-20 ; S1 : 21-39 ; S2 : 40-59 ; S3 : 60 et + | C.3.1 |
| RM-26 | Catégories de classement Tir à 18m : Arc Classique (U13 à S3), Arc à Poulies (U15 regroupant U13-U15, puis U18 à S3), Arc Nu (U18 regroupant U15-U18, puis Toutes Catégories regroupant U21 à S3) | C.5.1.3 §3.2 |
| RM-27 | Surclassement : catégorie immédiatement supérieure uniquement ; double surclassement interdit sauf S3 → S1 ; certificat médical selon les cas (voir specs/categories-ffta.spec.md) | C.3.2 |
| RM-28 | U11 en compétition officielle (dès 8 ans) : Tir à 18m sur blason de 80 cm, arc classique uniquement, puissance ≤ 18 livres (sinon certificat médical spécifique) ; aucun titre national | C.3.1.1 |
| RM-29 | Un archer sans nouvelle licence au 15 octobre perd le bénéfice des scores réalisés depuis le début de saison | C.3.1 |
| RM-30 | Licences Découverte et Sans Pratique : compétitions officielles non autorisées | C.3.1 |

## 4.6 Formats d'épreuve (Phase 1 — Tir à 18m)

| Id | Règle | Article |
|---|---|---|
| RM-31 | Épreuve de qualification 2×18 m : 2 séries de 10 volées de 3 flèches ; blason de 40 cm (ou trispot) selon les catégories ; temps de tir : 2 minutes par volée de 3 flèches | II.2.A / B.5 |
| RM-32 | Une session d'entraînement (3 volées) est due avant chaque départ | B.1.1 / B.7 |
