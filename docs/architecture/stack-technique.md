# Architecture technique — Linux / Windows / Android / iOS

> **Statut : proposition d'architecture soumise à validation.** Aucune implémentation n'a
> commencé à ce stade ; un plan d'implémentation distinct sera soumis avant tout scaffolding
> de code. Ce document est technique — il complète, sans le remplacer, le
> [dossier de spécifications](../specifications/00-lisez-moi.md) destiné aux relecteurs non
> informaticiens.

## 1. Contexte et contraintes

Cette proposition répond à un besoin exprimé de couvrir Linux, Windows, Android et iOS, en
tenant compte des contraintes déjà posées par le dossier de spécifications :

- **ENF-01** (fonctionnement sans Internet fiable) et **QO-02** (conditions matérielles et
  réseau le jour J) : l'application doit pouvoir fonctionner sans dépendre d'un réseau.
- **ENF-04** (sauvegarde et reprise) : une panne ne doit pas faire perdre plus d'une volée de
  saisie.
- **ENF-06** (impression A4 propre) : le papier reste la référence officielle.
- **ENF-09** (multi-appareils) : consultation des classements sur smartphone.
- **QO-08** (hébergement et responsabilité) : le mode local/hébergé n'est pas tranché pour les
  phases ultérieures.

Quatre décisions ont été arbitrées avec le porteur du projet et servent de base à cette
proposition :

1. **Local-first, un seul poste** pour la Phase 1 : le poste du greffe fonctionne entièrement en
   local, sans dépendance réseau. Un mode LAN/serveur/hébergé reste une extension future
   (Phase 3, QO-08), pas un prérequis. *Pourquoi* : c'est la seule architecture qui satisfait
   ENF-01 sans hypothèse optimiste sur la qualité du réseau en gymnase. Ce poste unique est en
   pratique **partagé entre plusieurs rôles humains** (organisateur, greffe, marqueur, arbitre —
   voir [chapitre 3.2 du dossier de spécifications](../specifications/03-acteurs-parcours.md) et
   ENF-12), pas réservé à un seul utilisateur : ce n'est donc pas un poste « mono-utilisateur »
   au sens strict, seulement une machine physique unique.
2. **100% JavaScript/TypeScript** : pas de Rust (Tauri), pas de Dart (Flutter). *Pourquoi* :
   projet open source dont les contributeurs sont attendus côté web (JS/TS) ; un langage
   supplémentaire élèverait la barrière de contribution sur les parties desktop/mobile.
3. **Mobile = consultation seule** (classements/résultats) : pas de saisie de scores sur mobile
   en Phase 1. *Pourquoi* : c'est la seule exigence mobile réellement posée à ce stade (ENF-09) ;
   une app de saisie mobile hors-ligne avec synchronisation serait une extension structurante
   non demandée (cf. QO-03, encore ouverte).
4. **NestJS conservé** comme couche backend complète (plutôt que simplifié en IPC direct dans
   Electron). *Pourquoi* : un seul pattern d'accès aux données (HTTP/DTOs) partagé par
   l'interface desktop et la vue de consultation mobile, ce qui évite de dupliquer les
   conventions déjà documentées dans `CLAUDE.md` (controller/service/module/dto, tests Jest) et
   prépare la réversibilité Phase 3 sans réécriture. L'alternative (IPC direct + micro-serveur
   séparé pour le mobile) a été examinée et écartée : elle introduirait deux patterns d'accès
   pour un gain de simplicité marginal sur ce poste unique, où le coût d'un aller-retour HTTP
   local est négligeable au regard de ENF-05.

## 2. Stack recommandée par plateforme

| Plateforme | Solution | Justification |
|---|---|---|
| Linux / Windows (poste greffe) | **Electron** + `electron-builder` | Seule techno 100% JS/TS mature pour desktop cross-OS ; écosystème et bassin de contributeurs bien plus large que l'alternative NW.js, pour un coût poids/mémoire équivalent |
| Android / iOS (consultation) | **PWA** (`vite-plugin-pwa`) servie par le même frontend, accessible en LAN depuis le poste greffe | Pas de store, pas de codebase séparée ; les limites connues des PWA iOS (cache purgé, pas de push) n'ont aucun impact sur un simple usage de consultation en réseau local |
| Backend | **NestJS**, inchangé, bootstrappé dans le process principal Electron (`NestFactory.create`, écoute `127.0.0.1`/`0.0.0.0`) | Le même code métier (`backend/src/**`) tourne à l'identique en desktop embarqué ou en serveur classique futur — seul `electron/main.ts` est le point d'intégration Electron-spécifique |
| Base de données | **SQLite** via **Prisma** (pas TypeORM) | SQLite = zéro serveur à installer, cohérent avec « un seul poste ». Prisma plutôt que TypeORM car son tooling (`binaryTargets`, génération multi-plateforme) gère le cross-packaging Electron de façon bien plus fiable que le rebuild manuel de modules natifs (`better-sqlite3`/`sqlite3`) qu'imposerait TypeORM |
| Impression (ENF-06) | **Puppeteer** côté NestJS pour générer les PDF (feuilles de marque, résultats), déclenchés depuis l'UI | Contrôle total de la mise en page A4 indépendamment de l'écran ; même service réutilisable en mode serveur (Phase 3) |

### Où tourne NestJS dans Electron

NestJS est bootstrappé dans le **processus principal (main process)** d'Electron, qui écoute en
HTTP sur `127.0.0.1:<port>`. Le renderer (React) parle à ce serveur exactement comme il parlerait
à un serveur distant. Le module racine NestJS (`backend/src/**`) est strictement identique que
l'app tourne dans Electron ou dans un conteneur Docker classique ; seul `electron/main.ts` est le
point d'intégration Electron-spécifique. `backend/src/main.ts` reste l'entrée serveur « pure »,
utilisée en Phase 3 / CI / tests, sans dépendance à Electron.

### Distribution de l'installeur (ENF-13)

`electron-builder` produit les artefacts d'installation ciblés (§1) : `.exe` (NSIS) pour Windows,
`AppImage`/`.deb` pour Linux. Ces artefacts sont publiés en tant qu'assets d'une **GitHub
Release** du dépôt du projet à chaque version taguée — canal de distribution naturel pour un
projet open source, sans infrastructure d'hébergement dédiée. La publication elle-même
(déclenchement du build `electron-builder` et upload des artefacts sur la release au moment du
tag) relève d'un workflow CI (GitHub Actions), à détailler dans le plan d'implémentation, pas
dans ce document.

### Consultation mobile via LAN

Le backend NestJS expose une route API en lecture seule publique (classements/résultats
publiés). Le même frontend Vite/React sert cette vue en mode responsive sur une route dédiée
(ex. `/consultation/:concoursId`), distincte des routes de gestion du greffe. Le serveur écoute
sur `0.0.0.0` pour être accessible depuis n'importe quel appareil du réseau local via l'IP du
poste greffe. Limites connues des PWA sur iOS Safari (pas de push, cache offline purgé
agressivement) : sans impact ici, car il s'agit d'un usage de consultation en réseau local avec
rafraîchissement manuel, pas d'un mode hors-ligne persistant pour le mobile.

## 3. Sauvegarde continue (ENF-04 : perte max = 1 volée)

- SQLite en mode **WAL** (écritures durables sans bloquer les lectures — utile pendant que la
  vue de consultation LAN lit en même temps que le greffe écrit).
- **Commit après chaque volée** saisie (transaction Prisma) : la pire perte possible en cas de
  coupure est exactement la volée en cours, conforme à ENF-04.
- Copie de sauvegarde périodique du fichier `.sqlite` (+ WAL) vers un dossier `backups/` avec
  rotation, en défense en profondeur contre la corruption disque.

## 4. Structure de dépôt proposée

Cette structure est une **proposition à valider avant tout scaffolding**, pas un état déjà en
place :

```
package.json                 ← workspaces: backend, frontend, electron
backend/
  src/<ressource>/...        ← inchangé vs CLAUDE.md (controller/service/module/dto)
  src/main.ts                ← entrée serveur « pure » (Phase 3 / Docker / tests)
  src/public/                ← module dédié aux routes de consultation en lecture seule
  prisma/schema.prisma       ← datasource paramétrable (sqlite desktop / postgresql Phase 3)
  prisma/migrations/
  test/
frontend/
  src/pages/greffe/          ← saisie, authentifié
  src/pages/consultation/    ← vue publique responsive (PWA)
  vite.config.ts             ← intègre vite-plugin-pwa
electron/
  main.ts                    ← bootstrap Electron + Nest
  preload.ts
  builder.config.yml         ← targets nsis (Windows) + AppImage/deb (Linux)
```

Ajout minimal par rapport à la structure déjà annoncée dans `CLAUDE.md` : un troisième
workspace `electron/`, sans toucher aux conventions `backend/src/<ressource>/...` et
`frontend/src/...` existantes.

## 5. Réversibilité future (Phase 3, QO-08)

Bascule vers un mode serveur classique (Docker + Postgres) sans réécriture du code métier :
changer `provider = "sqlite"` → `"postgresql"` dans `schema.prisma`, régénérer le client, rejouer
les migrations. `backend/src/main.ts` (déjà l'entrée non-Electron) se déploie tel quel en
conteneur ; le frontend buildé est servi par Nest (`ServeStaticModule`) ou un CDN au lieu
d'Electron. La route de consultation publique devient accessible sur Internet sans changement de
code.

## 6. Poste partagé entre rôles et supports amovibles (ENF-12)

L'hypothèse retenue (§1, décision 1) d'un poste unique **partagé entre plusieurs rôles humains**
a des implications de sécurité que l'architecture doit prendre en compte, en plus de
l'authentification par rôle déjà prévue (EF-60) :

- **Changement d'utilisateur** : l'application doit forcer une déconnexion/verrouillage de
  session entre deux utilisateurs successifs du même poste (pas de session laissée ouverte
  quand l'organisateur cède la main au greffe, au marqueur ou à l'arbitre). Mécanisme à détailler
  dans le plan d'implémentation (ex. écran de verrouillage applicatif indépendant du
  verrouillage OS, changement de compte explicite plutôt qu'une session partagée unique).
- **Sauvegarde et échange sur support amovible** : si une clé USB est utilisée en complément de
  la sauvegarde automatique locale (§3) — copie de secours, transfert vers un autre poste,
  archivage post-concours — le fichier copié contient des données personnelles d'archers et doit
  donc être **chiffré** (ex. archive chiffrée par mot de passe, ou chiffrement au niveau fichier)
  et **effacé de façon sécurisée** après usage. Un support perdu ou volé ne doit exposer aucune
  donnée en clair.
- **Clé USB comme vecteur de risque** : ne l'utiliser que comme support de stockage de données,
  jamais pour exécuter du contenu depuis celle-ci ; recommandation d'usage (bonne pratique
  utilisateur) plutôt que contrôle technique bloquant en Phase 1.
- Ces points sont documentés côté produit dans le dossier de spécifications
  ([chapitre 6, ENF-12](../specifications/06-exigences-non-fonctionnelles.md) et
  [chapitre 7.5](../specifications/07-donnees-rgpd.md)) ; leur traduction technique précise
  (bibliothèque de chiffrement, UX du changement de session) reste à trancher dans le plan
  d'implémentation, pas dans ce document.

## 7. Transfert de configuration chiffré entre postes (ENF-14)

Un nouveau rôle **Administrateur** (voir [chapitre 3 du dossier de spécifications](../specifications/03-acteurs-parcours.md))
gère la configuration technique de l'application, distincte des données d'un concours. Cette
distinction se traduit directement dans le schéma Prisma (§4) : les modèles **Compte
utilisateur** (identifiant, mot de passe haché, rôle) et **Paramètres techniques** (réglages
d'impression, emplacement des sauvegardes, etc.) sont séparés des modèles de données de concours
(archers, scores, résultats) — pas nécessairement dans des fichiers SQLite distincts, mais au
moins comme un sous-ensemble de tables clairement identifiable.

L'export (EF-70) sérialise uniquement ce sous-ensemble (comptes + paramètres) dans une archive
**chiffrée** (même approche de chiffrement que pour la sauvegarde sur support amovible, §6),
transférable par clé USB ou tout autre moyen entre deux postes du même club. L'import (EF-71) sur
le nouveau poste recrée les comptes et applique les paramètres, **sans toucher** aux données de
concours déjà présentes sur ce poste (l'import ne doit ni les écraser, ni en dépendre). Aucune
donnée personnelle d'archer ne transite par ce mécanisme — conformément au principe retenu au
[chapitre 7 du dossier de spécifications](../specifications/07-donnees-rgpd.md).

## 8. Prochaines étapes

Cette proposition doit être validée (relecteurs techniques, ou simplement confirmation du
porteur de projet) avant qu'un plan d'implémentation distinct ne soit soumis, couvrant le
scaffolding concret (monorepo, Prisma, Electron, tests) dans l'ordre décrit à titre indicatif
en §4.
