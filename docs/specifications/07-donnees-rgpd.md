# 7. Données personnelles et RGPD

Le club organisateur est **responsable de traitement** au sens du RGPD. Ce chapitre décrit les
données envisagées et les principes retenus ; il alimentera le registre des traitements
(art. 30 RGPD) tenu dans le dépôt du projet (docs/rgpd/registre-traitements.md).

## 7.1 Données traitées

| Catégorie | Données | Nécessité |
|---|---|---|
| Identité | Nom, prénom, sexe, date de naissance | Obligatoire : résultats officiels (RM-07) et calcul de catégorie (RM-25) |
| Licence | N° de licence, club, type de licence, surclassement | Obligatoire : contrôle au greffe (RM-03), résultats |
| Contact | Adresse électronique (organisateur/inscription) | À minimiser — voir [QO-04](08-questions-ouvertes.md) |
| Sportif | Scores, classements, catégorie | Obligatoire : objet même de l'application ; données publiées |
| Comptes | Identifiant, mot de passe haché, rôle | Utilisateurs de l'application uniquement |

## 7.2 Point d'attention : certificat médical

Certaines situations font intervenir des **données de santé** (catégorie sensible, art. 9 RGPD) :
certificat médical de surclassement, certificat de puissance pour les U11 (RM-27, RM-28).

Principe proposé : l'application **ne stocke aucun certificat médical**. Elle enregistre uniquement
le fait attesté (« surclassement U15 accordé », « certificat présenté au greffe »), la vérification
du document restant humaine. Ce choix évite un traitement de données de santé et l'analyse d'impact
(AIPD) qui pourrait en découler. **Soumis à validation** — voir [QO-04](08-questions-ouvertes.md).

## 7.3 Bases légales envisagées

| Traitement | Base légale proposée |
|---|---|
| Gestion des inscriptions et du greffe | Exécution d'un contrat (participation au concours) |
| Établissement et publication des résultats | Obligation réglementaire fédérale pour l'organisateur ; intérêt légitime pour la publication sportive |
| Comptes utilisateurs | Intérêt légitime (fonctionnement de l'outil) |

Ces qualifications seront précisées avec la revue de conformité (/rgpd-check) avant développement.

## 7.4 Durées de conservation (proposition)

| Données | Durée proposée |
|---|---|
| Inscriptions et données de greffe | Saison en cours + 1 an |
| Résultats officiels (publiés) | Conservation longue (archive sportive du club) — anonymisation non pertinente pour des résultats nominatifs officiels |
| Comptes utilisateurs | Suppression à la fin de l'activité de l'utilisateur |
| Journaux (ENF-03) | 6 mois à 1 an (recommandation CNIL) |

## 7.5 Droits des personnes et sécurité

- Information des archers lors de l'inscription (mention d'information : finalités, destinataires, durées, droits) ;
- Exercice des droits (accès, rectification, effacement dans les limites des obligations fédérales) via le club organisateur ;
- Mesures de sécurité : authentification, hachage robuste des mots de passe, chiffrement des sauvegardes, journalisation (ENF-02 à ENF-04), notification CNIL sous 72 h en cas de violation ;
- Poste partagé (ENF-12, chapitre 3.2) : verrouillage/déconnexion obligatoire entre deux utilisateurs successifs du même poste physique ; toute copie de données personnelles sur support amovible (clé USB, sauvegarde ou échange) chiffrée et effacée de façon sécurisée après usage — un support perdu ou volé ne doit exposer aucune donnée en clair ;
- Transfert de configuration entre postes du club (ENF-14) : seuls les comptes utilisateurs (identifiants, rôles) et les paramètres techniques de l'application sont transférés, de façon chiffrée — **aucune donnée personnelle d'archer ni donnée de concours n'est incluse dans cet export** ; principe de minimisation appliqué au transfert lui-même, pas seulement au stockage ;
- Destinataires : club organisateur, FFTA (transmission réglementaire des résultats), public (résultats sportifs uniquement).
