# to-toxon-odysseos — Instructions pour Claude

## Contexte du projet

**to-toxon-odysseos** est une application de gestion des concours de tir à l'arc conformes FFTA (Fédération Française de Tir à l'Arc).
L'utilisateur communique en **français** — répondre dans cette langue par défaut.

## Stack technique

| Couche    | Technologie          |
|-----------|-----------------------|
| Backend   | Node.js / NestJS (TypeScript) |
| Frontend  | React + Vite (TypeScript) |
| Tests backend | Jest |
| Tests frontend | Vitest + Testing Library |

## Structure du projet

Projet neuf — aucune structure de code encore créée. Structure standard à mettre en place :

```
backend/
  src/
    <ressource>/
      <ressource>.controller.ts
      <ressource>.service.ts
      <ressource>.module.ts
      dto/
      entities/
  test/
frontend/
  src/
    components/
    pages/
    services/
```

## Conventions de nommage

- Backend (NestJS) : camelCase pour variables/fonctions, PascalCase pour classes/DTOs/entités, kebab-case pour les noms de fichiers (`concours.service.ts`)
- Frontend (React) : PascalCase pour les composants, camelCase pour hooks/fonctions

## Règles de développement

1. Ne jamais committer les fichiers contenant des secrets (`.env`, etc.)
2. Les connection strings et clés API vont dans des fichiers exclus du git
3. Les endpoints API suivent REST : `GET /api/[ressource]`, `POST /api/[ressource]`, etc.
4. Utiliser des DTOs pour les échanges API (ne jamais exposer les entités directement)
5. Respecter les règles métier FFTA pour tout calcul de scores, catégories ou classements

## Sécurité des données et conformité RGPD

Principe général du projet : toute donnée personnelle d'archer (identité, date de naissance,
licence FFTA, résultats, certificat médical) est traitée conformément au RGPD.

- Le hook `.claude/hooks/rgpd-scan.ps1` (PostToolUse) scanne automatiquement toute création/
  modification d'entité, DTO ou controller backend et journalise les avertissements dans
  le fichier de session du jour (section "Alertes RGPD")
- Avant tout scaffolding d'entité touchant des données personnelles → exécuter `/rgpd-check`
  (revue approfondie : base légale, durée de conservation, minimisation, registre des traitements)
- Le certificat médical et toute donnée de santé (art. 9 RGPD) sont une catégorie sensible :
  traitement, base légale et sécurisation spécifiques obligatoires
- Registre des traitements : `docs/rgpd/registre-traitements.md` (Art. 30 RGPD)
- Les mots de passe doivent être hachés avec un algorithme robuste (bcrypt/argon2/scrypt) —
  recommandation CNIL, vérifié par `rgpd-scan.ps1`
- Toute donnée de santé (certificat médical) déclenche une évaluation AIPD (CNIL) via
  `/rgpd-check` — voir `docs/okf/references.md` § Règles CNIL

## Commandes fréquentes

```
[Backend]   npm run start:dev
[Frontend]  npm run dev
```

## Workflow avec Claude

- Avant de créer une entité ou un service → vérifier les entités/services existants dans `docs/okf/`
- Après modification d'une entité → proposer une migration (TypeORM/Prisma selon l'ORM retenu)
- Après ajout d'un endpoint → mettre à jour le service frontend correspondant
- Toujours scaffolder complet : Entité → Repository → Service → Controller → DTO → Service frontend
  — sauf si l'utilisateur limite explicitement le périmètre
- Après création ou modification d'une entité, service ou controller → exécuter `/generate-okf <NomEntité>` (skill global)
- Après toute modification de `docs/okf/` → exécuter `/generate-viz` pour régénérer `docs/okf/viz.html`
- Après scaffolding d'une entité ou d'un DTO touchant des données personnelles d'archer → exécuter `/rgpd-check`

## Modes de réponse

### Mode focus (défaut)
- Répondre uniquement à ce qui est demandé
- N'ajouter une information non demandée que si elle est directement actionnelle
  dans le contexte immédiat de la question
- Pas de reformulation de la question
- Niveau d'abstraction : celui de la question posée
- Longueur : minimale

### Mode exploration
Activé explicitement par le mot-clé `[exploration]`.
- Explorer librement les idées, même spéculatives ou incomplètes
- Ne pas limiter les suggestions au périmètre strict de la demande
- Ne pas exiger de critères de succès ni de plan formel
- Proposer des alternatives, contre-exemples, approches divergentes
- Niveau d'abstraction : conceptuel d'abord, technique si demandé
- Longueur : développée

### Contrôle des modifications en mode exploration
1. Avant la première édition de fichier → commit de sauvegarde :
   `git add -A && git commit -m "chore: rollback point — début exploration"`
2. Chaque hypothèse explorée → commit atomique préfixé `[exploration]`
3. À la sortie → lister les commits `[exploration]` et demander lesquels conserver/abandonner
4. Aucun push des commits `[exploration]` sans accord explicite

## Directives comportementales

> Les règles projet (§ Règles de développement, § Workflow avec Claude) priment
> sur ces directives. Elles sont suspendues en mode exploration.

Principes formulés par Andrej Karpathy pour orienter le comportement des assistants IA dans les tâches de développement logiciel. Claude doit les appliquer en toutes circonstances. Voir `docs/okf/references.md`.

### 1. Réfléchir avant de coder
- Ne pas supposer — énoncer explicitement les hypothèses
- Poser les questions de clarification avant de commencer
- Ne pas masquer la confusion derrière du code

### 2. Simplicité d'abord
- Code minimum qui résout le problème
- Pas de fonctionnalités spéculatives ni d'abstractions inutiles
- Si 200 lignes peuvent devenir 50, réécrire

### 3. Modifications chirurgicales
- Toucher uniquement le strict nécessaire
- Respecter le style existant
- Ne pas supprimer de code mort préexistant sans demande explicite

### 4. Exécution orientée objectifs
- Définir les critères de succès avant d'agir
- Transformer chaque tâche en objectif vérifiable
- Énoncer un plan bref avec points de contrôle, puis itérer jusqu'à vérification

## Workflow TDD (Test-Driven Development)

> **Déclencheurs** : Toute demande impliquant la création ou modification de code (entité, service, controller, repository, composant frontend, hook, migration, endpoint) déclenche obligatoirement ce workflow — même si la demande est formulée conversationnellement.

### Processus obligatoire pour chaque fonctionnalité

```
1. Mode plan      → Shift+Tab dans Claude Code, valider l'approche
2. Spécifications → Créer/mettre à jour specs/NomFeature.spec.md
3. Tests d'abord  → Écrire les tests (Red : ils doivent échouer)
4. Code minimal   → Écrire le minimum pour faire passer les tests (Green)
5. Refactor       → Nettoyer sans casser les tests
6. Scaffolding    → Appliquer le workflow complet habituel
```

### Fichiers de spécifications

- Emplacement : `specs/NomFeature.spec.md` à la racine du projet
- Format : voir `specs/_template.spec.md`

### Tests backend (NestJS / Jest)

- Projet : `backend/test/`
- Setup (première fois) : voir `.claude/docs/tests-setup.md`
- Lancer : `npm test`
- Convention de nommage : `NomService_NomMéthode_ComportementAttendu`

### Tests frontend (React / Vitest)

- Setup (première fois) : voir `.claude/docs/tests-setup.md`
- Lancer : `npm test` / `npx vitest`

## Journal de session

Les modifications sont tracées automatiquement par le hook `.claude/hooks/session-journal.ps1`
(déclenché sur `Write` / `Edit` / `NotebookEdit`).

- **Emplacement** : `.claude/sessions/YYYY-MM-DD_HH-mm_session.md`
- **À compléter en fin de session** : titre, contexte, descriptions dans la colonne "Description"
- **Template** : `.claude/sessions/_template.md`

## graphify

Ce projet dispose d'un graphe de connaissance dans `graphify-out/`.

Règles :
- Pour les questions sur la base de code, exécuter d'abord `graphify query "<question>"` quand `graphify-out/graph.json` existe.
- Utiliser `graphify path "<A>" "<B>"` pour les relations entre concepts.
- Utiliser `graphify explain "<concept>"` pour les concepts ciblés.
- Lire `graphify-out/GRAPH_REPORT.md` uniquement pour une revue d'architecture large.
- Après modification du code, exécuter `graphify update .` pour maintenir le graphe à jour.

## Contexte automatique

@docs/okf/index.md
