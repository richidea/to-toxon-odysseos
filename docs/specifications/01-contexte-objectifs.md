# 1. Contexte et objectifs

## 1.1 Le besoin

Organiser un concours de tir à l'arc conforme aux règlements de la Fédération Française de Tir à l'Arc
(FFTA) impose à un club une chaîne de tâches administratives et sportives précises : publication du
mandat, gestion des inscriptions, tenue du greffe le jour de la compétition (contrôle des licences,
attribution des cibles), suivi des feuilles de marque, calcul des classements par catégorie, édition
des résultats et transmission à la fédération dès la fin de la compétition.

Ces tâches sont aujourd'hui réalisées avec des outils hétérogènes (tableurs, papier, logiciel fédéral
vieillissant), avec des risques d'erreur sur les points les plus sensibles : conformité de
l'attribution des cibles, exactitude des classements (règles de départage), délais de transmission
des résultats — le règlement prévoit des **pénalités lourdes** en cas de manquement (jusqu'à 2 ans de
suppression d'organisation, art. B.1.4).

## 1.2 L'existant fédéral

- **Résult'Arc** : logiciel historique de la FFTA pour les inscriptions et les résultats (Windows,
  poste local). Il génère un fichier de résultats transmis via l'extranet fédéral. Le format technique
  de ce fichier n'est pas public.
- **IANSEO** : logiciel international, en cours de déploiement par la FFTA (saison 2025-2026 : Tir à
  18m, TAE, Beursault) en remplacement progressif de Résult'Arc. Transmission également par fichier
  vers l'extranet, intégration au classement national sous 2 heures.

L'application envisagée ne remplace pas le système fédéral : elle outille le club organisateur en
amont et pendant la compétition, et produit en sortie les éléments attendus par la fédération
(résultats conformes, fichier d'export si le format peut être obtenu — voir [QO-01](08-questions-ouvertes.md)).

## 1.3 Objectifs

| Id | Objectif | Bénéfice attendu |
|---|---|---|
| OBJ-01 | Garantir la conformité FFTA des concours organisés (greffe, scores, classements, résultats) | Zéro pénalité fédérale, résultats incontestables |
| OBJ-02 | Réduire le temps de préparation et de tenue du greffe | Moins de bénévoles mobilisés, moins d'erreurs le jour J |
| OBJ-03 | Fiabiliser la saisie des scores et le calcul des classements (départages compris) | Publication rapide et juste des podiums |
| OBJ-04 | Faciliter la transmission des résultats à la FFTA dès la fin de la compétition | Respect du délai réglementaire (art. B.1.4) |
| OBJ-05 | Protéger les données personnelles des archers conformément au RGPD | Conformité légale du club organisateur |

## 1.4 Ce que l'application n'est pas

- Un système de gestion des licences (domaine exclusif de la FFTA) ;
- Un remplacement de Résult'Arc/IANSEO côté fédération ;
- Un outil de gestion administrative ou comptable du club.
