# 3. Acteurs et parcours utilisateur

## 3.1 Acteurs

| Acteur | Rôle vis-à-vis de l'application |
|---|---|
| Administrateur | Rôle technique : configure l'application (comptes utilisateurs, paramètres techniques), gère le transfert de la configuration entre postes du club — n'intervient pas sur l'organisation sportive d'un concours |
| Organisateur | Membre du club organisateur ; crée le concours, publie le mandat, suit les inscriptions, édite et transmet les résultats |
| Greffe | Bénévole(s) tenant le greffe le jour J : contrôle des licences, pointage, attribution des cibles, gestion des défections |
| Marqueur | Personne désignée par cible qui enregistre les scores (souvent un compétiteur) |
| Arbitre | Vérifie la conformité ; tranche la valeur des flèches ; valide les corrections de feuilles de marque |
| Archer | Compétiteur ; s'inscrit (ou est inscrit), vérifie et signe sa feuille de marque, consulte les résultats |
| Dirigeant de club | Consulte les concours et résultats du club ; responsable de traitement au sens RGPD |

Un même individu peut cumuler plusieurs rôles (un organisateur est souvent archer).

## 3.2 Hypothèse de poste partagé (Phase 1)

Hypothèse de travail retenue pour la Phase 1, à confirmer par les relecteurs (voir
[QO-02](08-questions-ouvertes.md) et [QO-03](08-questions-ouvertes.md)) : **un seul poste
informatique** (Windows ou Linux) au greffe assure l'ensemble des rôles applicatifs.
Organisateur, greffe, marqueur(s) et arbitre s'y succèdent au cours de la compétition, chacun
avec son propre compte utilisateur (EF-60) — le poste est donc **partagé entre plusieurs
personnes**, et non réservé à un seul utilisateur. Cette hypothèse a des conséquences directes
sur la sécurité des accès (voir ENF-12) et sur la saisie des scores (saisie centralisée plutôt
que décentralisée sur les téléphones des marqueurs).

## 3.3 Parcours utilisateur

Chaque parcours est décrit du point de vue de l'acteur principal. Les exigences fonctionnelles du
chapitre 5 s'y rattachent.

### P-01 — Préparer un concours (organisateur)

Créer le concours (discipline, dates, lieu, nombre de cibles, départs et horaires, blasons proposés),
renseigner les informations obligatoires du mandat (art. B.1.1 : heure d'ouverture du greffe,
inspection du matériel, entraînement, début des tirs, forme du concours), désigner les arbitres,
puis diffuser le mandat.

### P-02 — Gérer les inscriptions (organisateur)

Enregistrer les inscriptions (archer, club, catégorie, départ souhaité, arme), contrôler la validité
des données (licence, catégorie calculée automatiquement, surclassement éventuel), suivre le taux de
remplissage par départ, gérer une liste d'attente.

### P-03 — Tenir le greffe le jour J (greffe)

À l'ouverture : contrôler les licences, pointer les présents, encaisser les mises. Attribuer les
cibles en respectant les règles fédérales (2 archers maximum d'un même club par cible, participation
d'archers extérieurs obligatoire) ; réattribuer en cas de défection sans casser ces règles ; éditer
le plan de cibles et les feuilles de marque.

### P-04 — Saisir les scores (marqueur)

Pour chaque volée : saisir les valeurs des flèches par archer (l'application les ordonne en
décroissant et calcule les totaux et le nombre de 10 et de 9), signaler un incident (flèche M,
rebond, désaccord → appel arbitre). En fin de tir : vérification et signature de l'archer et du
marqueur, verrouillage de la feuille.

### P-05 — Superviser et corriger (arbitre)

Consulter l'avancement des scores en temps réel, enregistrer une correction validée (tracée, avec
identification de l'arbitre), trancher les cas particuliers de valeur de flèche, constater une
divergence entre feuille papier et saisie électronique (le papier fait foi).

### P-06 — Classer et éditer les résultats (organisateur)

Lancer le calcul des classements par catégorie (départages automatiques : nombre de 10, puis de 9,
puis ex æquo), vérifier, éditer les résultats conformes à l'art. B.1.3 (date, lieu, club, arbitres,
participants par catégorie, scores) pour affichage et podiums.

### P-07 — Transmettre les résultats à la FFTA (organisateur)

Dès la fin de la compétition, produire le fichier de résultats au format attendu par la fédération
(ou, à défaut, un export exploitable) et le transmettre via l'extranet fédéral, dans le délai
réglementaire.

### P-08 — Consulter (archer, dirigeant)

Consulter le mandat, sa propre inscription, ses scores et les classements publiés du concours.

### P-09 — Administrer l'application (administrateur)

Créer et gérer les comptes utilisateurs (identifiants, rôles), configurer les paramètres
techniques de l'application (ex. réglages d'impression, emplacement des sauvegardes),
exporter/importer cette configuration de façon chiffrée pour équiper un nouveau poste du club
sans reconfiguration complète — cet export ne contient ni donnée personnelle d'archer, ni donnée
de concours (voir EF-70, EF-71, ENF-14).
