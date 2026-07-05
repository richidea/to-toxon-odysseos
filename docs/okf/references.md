---
type: Reference
title: Références externes — to-toxon-odysseos
description: Liens vers les ressources externes utilisées dans le projet
tags: [references]
timestamp: 2026-07-04
---

# Références externes

## Directives comportementales (Karpathy)

- [multica-ai/andrej-karpathy-skills (GitHub)](https://github.com/multica-ai/andrej-karpathy-skills)
- [Tweet original de Karpathy](https://x.com/karpathy/status/2015883857489522876)
- [Vidéo YouTube](https://www.youtube.com/watch?v=hzQie4EucY0)

## Hooks Claude Code

- [Claude Code — Hooks documentation](https://docs.anthropic.com/fr/docs/claude-code/hooks)

## Open Knowledge Format (OKF)

- [knowledge-catalog (GitHub)](https://github.com/GoogleCloudPlatform/knowledge-catalog) — dépôt principal, source de l'outil `reference_agent` (visualiseur OKF)
- [SPEC.md (GitHub)](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)
- [Open Knowledge Format — groundingpage.com](https://groundingpage.com/facts/open-knowledge-format/)

## Graphify

- [graphifyy (PyPI)](https://pypi.org/project/graphifyy/)

## Règles FFTA (tir à l'arc)

- [Fédération Française de Tir à l'Arc — site officiel](https://www.ffta.fr/)
- [Statuts et règlements FFTA](https://www.ffta.fr/la-federation/linstitution/statuts-et-reglements)
- [Règlements Sportifs et Arbitrage — Saison Sportive 2025, Édition Juillet 2025 (PDF officiel)](https://www.ffta.fr/sites/default/files/2025-07/R%C3%A9glements%20Sportifs%20et%20Arbitrage_Saison%20Sportive%202025_Juillet%202025.pdf)
  Chapitre I.B "Les Organisations" (organisation des concours) converti en markdown : [specs/organisation-concours-ffta.spec.md](../../specs/organisation-concours-ffta.spec.md)
  Chapitres II.1/II.2 B.5-B.6 "Établissement des scores" (décompte des points, TAE et Tir à 18m) converti en markdown : [specs/decompte-points-ffta.spec.md](../../specs/decompte-points-ffta.spec.md)
  Chapitre I.C.3 "Catégories, surclassements" + tableau des catégories du classement national converti en markdown : [specs/categories-ffta.spec.md](../../specs/categories-ffta.spec.md)
- [Règlements Sportifs et Arbitrage — Version Décembre 2023 Consolidée (PDF, version antérieure)](https://www.ffta.fr/sites/default/files/2023-12/R%C3%A9glements%20Sportifs%20et%20Arbitrage_Version%20D%C3%A9cembre%202023%20Consolid%C3%A9e.pdf)
- [Règlement intérieur de la FFTA (adopté AG 2023, PDF)](https://www.ffta.fr/sites/ffta/files/ri_ffta_adopte_ag_2023.pdf)

## Règles CNIL

- [Guide de la sécurité des données personnelles (CNIL, édition 2024)](https://www.cnil.fr/sites/cnil/files/2024-03/cnil_guide_securite_personnelle_2024.pdf) — mots de passe, contrôle d'accès, journalisation, chiffrement, sauvegardes
- [Listes des traitements pour lesquels une AIPD est requise ou non (CNIL)](https://www.cnil.fr/fr/listes-des-traitements-pour-lesquels-une-aipd-est-requise-ou-non)
- [Notifier une violation de données personnelles (CNIL)](https://www.cnil.fr/fr/services-en-ligne/notifier-une-violation-de-donnees-personnelles) — délai 72h via `notifications.cnil.fr`

## Export des résultats vers la FFTA

- [Gérez les résultats avec Résult'Arc (page FFTA)](https://www.ffta.fr/vie-sportive/resultats/gerez-les-resultats-avec-resultarc)
- [Résult'Arc — Mode d'emploi (PDF)](https://www.ffta.fr/sites/ffta/files/aideresultarc.pdf) — décrit le workflow (`Fichier FFTA` → génère un fichier dans `c:\resultarc\cvf` → transfert via l'extranet fédéral) mais ne publie pas le format d'enregistrement (schéma de champs, encodage) du fichier TXT généré.
- [IANSEO](https://www.ianseo.net/) — logiciel international en cours de déploiement par la FFTA (saison 2025-26 : TAE, Tir à 18m, Beursault) en remplacement progressif de Résult'Arc ; export également au format TXT vers `extranet.ffta.fr`, intégré au classement national sous 2h.
- [Espace dirigeant FFTA — IANSEO](https://dirigeant.ffta.fr/ianseo) — portail réservé aux gestionnaires sportifs de club (authentification requise), probable emplacement de toute documentation technique plus détaillée.

**Non trouvé** : aucun schéma technique public (format d'enregistrement, encodage, délimiteurs) du fichier d'export vers la FFTA n'a été localisé. Le "cahier des charges informatique" complet est mentionné comme disponible uniquement sur demande auprès de la Direction Sportive de la FFTA (contact historique : Xavier Veray). À demander directement à la fédération si une intégration technique réelle est nécessaire.

## Liens spécifiques au projet — à compléter
