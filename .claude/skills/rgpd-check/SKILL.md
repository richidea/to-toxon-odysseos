---
name: rgpd-check
description: Revue de conformité RGPD des entités/DTOs/controllers backend touchant des données personnelles d'archer. Complète le hook automatique rgpd-scan.ps1 par une analyse des points non scriptables (base légale, durée de conservation, minimisation) et propose une mise à jour du registre des traitements.
---

# Skill : /rgpd-check

Revue de conformité RGPD centrée sur les données personnelles d'archer (identité, date de
naissance, licence FFTA, résultats, certificat médical). Ne duplique pas les vérifications
génériques de sécurité du code (OWASP, secrets, injections) — pour cela, utiliser le skill
global `/security-review`.

## Étape 1 — Collecte déterministe

Lister les fichiers backend modifiés (working tree + staged) :

```powershell
git diff --name-only HEAD
git diff --name-only --cached
```

Filtrer sur les entités, DTOs et controllers (`backend/src/**/entities/*.ts`,
`backend/src/**/dto/*.ts`, `backend/src/**/*.controller.ts`), puis exécuter le scan
déterministe sur cette liste :

```powershell
pwsh -NonInteractive -File .claude/hooks/rgpd-scan.ps1 -Files $fichiers
```

Le script journalise ses avertissements dans le fichier de session du jour
(`.claude/sessions/`, section "Alertes RGPD") — les relire avant de poursuivre.

## Étape 2 — Analyse des points non scriptables

Pour chaque champ ou traitement signalé à l'étape 1, déterminer avec l'utilisateur :

- **Base légale** du traitement (consentement, exécution d'un contrat, obligation légale FFTA,
  intérêt légitime)
- **Durée de conservation** (ex : durée de la saison sportive + délai légal d'archivage)
- **Minimisation** : le champ est-il réellement nécessaire à la finalité poursuivie ?
- **Droits des personnes concernées** : accès, rectification, effacement — un mécanisme existe-t-il ?
- Si donnée de santé (certificat médical, pathologie) : base légale renforcée (Art. 9 RGPD),
  confirmer qu'elle n'est pas stockée au-delà du strict nécessaire (ex : simple statut
  "valide/absent", pas le contenu du certificat)

## Checklist CNIL

En complément du texte légal RGPD, vérifier les recommandations pratiques de la CNIL :

- **Sécurité** ([Guide de la sécurité des données personnelles, CNIL 2024](https://www.cnil.fr/sites/cnil/files/2024-03/cnil_guide_securite_personnelle_2024.pdf)) :
  mots de passe hachés avec un algorithme robuste et salé (bcrypt/argon2/scrypt, jamais en clair
  ni en MD5/SHA1 simple), contrôle d'accès, journalisation des accès aux données sensibles,
  chiffrement au repos pour les données de santé, sauvegardes.
- **AIPD** ([Listes des traitements CNIL](https://www.cnil.fr/fr/listes-des-traitements-pour-lesquels-une-aipd-est-requise-ou-non)) :
  si le traitement figure dans la liste des 14 traitements où une AIPD est obligatoire, ou
  remplit au moins 2 des 9 critères G29 (le traitement de données de santé en est un), documenter
  la décision (AIPD requise ou non, et pourquoi) dans le registre des traitements.
- **Notification de violation** ([Notifier une violation, CNIL](https://www.cnil.fr/fr/services-en-ligne/notifier-une-violation-de-donnees-personnelles)) :
  rappel informatif — en cas de violation de données personnelles, notification à la CNIL sous
  72h (heures calendaires) via `notifications.cnil.fr`, en deux temps si l'enquête est incomplète.

## Étape 3 — Mise à jour du registre des traitements

Proposer une ligne (ou une mise à jour de ligne existante) pour
`docs/rgpd/registre-traitements.md`, à valider explicitement avec l'utilisateur avant écriture.

## Rappel

Ce skill ne se substitue pas à `/security-review` : il reste centré sur la donnée personnelle
et la conformité réglementaire, pas sur les vulnérabilités génériques de code.
