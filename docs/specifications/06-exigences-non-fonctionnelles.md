# 6. Exigences non fonctionnelles

| Id | Exigence | Priorité | Commentaire |
|---|---|---|---|
| ENF-01 | **Fonctionnement sans Internet fiable** : le jour J, l'application doit fonctionner dans un gymnase ou sur un terrain sans connexion garantie (réseau local ou mode hors-ligne avec synchronisation) | M | Point structurant pour l'architecture — voir [QO-02](08-questions-ouvertes.md) |
| ENF-02 | **Sécurité des accès** : authentification obligatoire pour toute action de gestion ; mots de passe hachés avec un algorithme robuste (recommandation CNIL) ; droits selon le rôle | M | Voir chapitre 7 et ENF-12 (poste partagé) |
| ENF-03 | **Traçabilité** : journalisation des accès et des actions sensibles (corrections de scores, exports de données personnelles), horodatée et attribuée | M | Guide CNIL sécurité 2024 |
| ENF-04 | **Sauvegarde et reprise** : sauvegarde automatique pendant la compétition ; une panne de la machine du greffe ne doit pas faire perdre plus d'une volée de saisie | M | |
| ENF-05 | **Performance jour J** : saisie d'une volée et recalcul des totaux perçus comme instantanés (< 1 s) ; classement complet d'un départ (~100 archers) en moins de 10 s | S | |
| ENF-06 | **Impression** : plans de cibles, feuilles de marque et résultats imprimables proprement en A4 depuis l'application | M | Le papier reste la référence officielle (RM-12) |
| ENF-07 | **Simplicité d'utilisation** : le greffe et la saisie doivent être utilisables par des bénévoles non informaticiens après une prise en main de moins de 30 minutes | M | À valider par les utilisateurs de terrain |
| ENF-08 | **Accessibilité** : interface lisible en conditions de gymnase (contraste, taille des caractères), utilisable au clavier | S | |
| ENF-09 | **Multi-appareils** : consultation des classements sur smartphone ; la saisie des scores sur tablette/smartphone est une option à trancher ([QO-03](08-questions-ouvertes.md)) | S | |
| ENF-10 | **Réversibilité** : toutes les données d'un concours exportables dans un format ouvert (CSV/JSON) | S | |
| ENF-11 | **Conformité RGPD** : voir chapitre 7 (minimisation, durées de conservation, droits des personnes) | M | |
| ENF-12 | **Poste partagé et supports amovibles** : le même poste physique (greffe) est utilisé successivement par plusieurs rôles (organisateur, greffe, marqueur, arbitre) ; verrouillage/déconnexion obligatoire entre deux utilisateurs, pas de session laissée ouverte ; toute copie de données personnelles sur support amovible (clé USB, pour sauvegarde ou échange) doit être chiffrée et effacée de façon sécurisée après usage | M | Hypothèse retenue en Phase 1 — voir chapitre 3.2, [QO-02](08-questions-ouvertes.md)/[QO-03](08-questions-ouvertes.md), chapitre 7 |
| ENF-13 | **Distribution** : un installeur/package d'installation (Windows, Linux) est publié sur le dépôt GitHub du projet (release) à chaque version, permettant l'installation par les utilisateurs finaux sans compilation ni compétence informatique | M | Voir docs/architecture/stack-technique.md |
| ENF-14 | **Transfert de configuration entre postes** : la configuration technique de l'application (comptes utilisateurs, paramètres techniques) est exportable/importable de façon chiffrée entre postes d'un même club, pour équiper un nouveau poste sans reconfiguration complète ; cet export ne contient aucune donnée personnelle d'archer ni donnée de concours | S | EF-70, EF-71, chapitre 7 |
