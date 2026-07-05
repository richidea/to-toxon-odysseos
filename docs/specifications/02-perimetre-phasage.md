# 2. Périmètre et phasage

## 2.1 Vision cible

À terme, l'application couvre le cycle complet d'un concours FFTA, pour les disciplines organisées
par les clubs :

| Domaine | Contenu |
|---|---|
| Référentiel | Archers (identité, licence, catégorie d'âge et d'arme calculées), clubs |
| Préparation | Création du concours, mandat/invitation, départs, inscriptions |
| Greffe | Contrôle des licences, pointage, attribution des cibles conforme au règlement |
| Compétition | Feuilles de marque, saisie des scores par volée, validations et signatures |
| Classements | Calcul par catégorie (sexe × âge × arme), départages réglementaires |
| Résultats | Édition conforme, publication, transmission FFTA |
| Disciplines | Tir à 18m, Tir à l'Arc Extérieur (TAE), puis autres disciplines selon priorités |

## 2.2 Phasage proposé

Le phasage ci-dessous est une **proposition soumise aux relecteurs** (voir [QO-05](08-questions-ouvertes.md)).

### Phase 1 — Concours Tir à 18m, épreuve de qualification (MVP)

La discipline la plus organisée par les clubs, sur son format le plus courant (2×18 m, volées de
3 flèches, sans phases finales) :

- référentiel archers/clubs, calcul automatique des catégories ;
- création du concours, départs, inscriptions ;
- greffe : contrôle licences, attribution des cibles (règles RM-01 à RM-03) ;
- saisie des scores, totaux et nombre de 10/9 automatiques ;
- classements par catégorie avec départage réglementaire ;
- édition des résultats conforme à l'art. B.1.3 (impression/PDF), export générique (CSV) ;
- installeur (Windows, Linux) publié sur le dépôt GitHub du projet, permettant l'installation
  par les utilisateurs finaux sans compilation (ENF-13).

### Phase 2 — Phases finales et TAE

- duels et matchs (système de sets arc classique/nu, score cumulé arc à poulies), barrages ;
- Tir à l'Arc Extérieur (distances, blasons, volées de 6 flèches, épreuve 1440) ;
- gestion par équipes (qualification).

### Phase 3 — Intégration fédérale et autres disciplines

- export au format attendu par la FFTA (Résult'Arc/IANSEO — conditionné à l'obtention du cahier
  des charges fédéral, [QO-01](08-questions-ouvertes.md)) ;
- disciplines de parcours (Campagne, Nature, 3D) et/ou Beursault, selon les priorités exprimées ;
- Para-tir à l'arc (prise en compte des catégories Open/Fédéral).

## 2.3 Hors périmètre (toutes phases)

- Gestion des licences fédérales (émission, renouvellement) — source : FFTA ;
- Paiement en ligne des mises (à discuter, [QO-06](08-questions-ouvertes.md)) ;
- Gestion administrative et comptable du club ;
- Chronométrage et signalétique de terrain (feux, sonorisation) ;
- Procédures disciplinaires et jury d'appel (le dossier de réclamation reste papier).
