# 8. Questions ouvertes soumises aux relecteurs

Ces points ne sont pas tranchés dans cette version du dossier. Chaque relecteur est invité à donner
son avis, même partiel, en citant l'identifiant QO-xx.

## QO-01 — Format d'export vers la FFTA

Le format technique du fichier de résultats attendu par la fédération (Résult'Arc, puis IANSEO)
n'est pas public. Le cahier des charges informatique serait disponible sur demande auprès de la
Direction Sportive de la FFTA.

**Questions** : qui, au club ou au comité, peut porter cette demande auprès de la FFTA ? Un contact
existe-t-il ? En attendant, un export CSV + saisie manuelle dans l'outil fédéral est-il acceptable ?

## QO-02 — Conditions matérielles et réseau le jour J

L'architecture dépend directement des conditions réelles en gymnase : y a-t-il une connexion
Internet fiable ? L'application doit-elle fonctionner sur une seule machine au greffe, ou sur
plusieurs postes en réseau local ?

**Questions** : décrivez l'installation type de vos concours (nombre de postes, qui saisit,
connexion disponible). Un fonctionnement 100 % local sur le poste du greffe est-il suffisant en
Phase 1 ?

**Proposition technique** : voir [docs/architecture/stack-technique.md](../architecture/stack-technique.md).

**Hypothèse retenue** : un poste unique, partagé entre tous les rôles applicatifs (voir chapitre
3.2, ENF-12) — à confirmer par les relecteurs.

## QO-03 — Qui saisit les scores, sur quel support ?

Deux modèles possibles (cumulables) : saisie centralisée au greffe à partir des feuilles papier
(après chaque série ou en fin de tir), ou saisie décentralisée par les marqueurs sur
tablette/smartphone au pas de tir (le papier restant la référence officielle, RM-12).

**Questions** : la saisie par les marqueurs sur leur propre téléphone est-elle réaliste dans vos
clubs (équipement, réticences, batterie, réseau) ? Pour la Phase 1, la saisie centralisée
suffit-elle ?

**Hypothèse retenue** : saisie centralisée sur le poste unique partagé (chapitre 3.2), à partir
des feuilles de marque papier — cohérente avec la décision « mobile = consultation seule » (voir
[docs/architecture/stack-technique.md](../architecture/stack-technique.md)) ; pas de saisie
décentralisée sur tablette/smartphone en Phase 1.

## QO-04 — Données personnelles : périmètre exact

Le dossier propose de ne stocker ni certificat médical ni donnée de santé (§ 7.2), et de minimiser
les données de contact.

**Questions** : la proposition « on enregistre le fait, pas le document » convient-elle aux
pratiques réelles du greffe ? L'adresse électronique des archers est-elle nécessaire (convocations,
envoi des résultats) ou peut-on s'en passer ?

## QO-05 — Priorités du phasage

La Phase 1 proposée couvre le Tir à 18m en épreuve de qualification, sans phases finales
(chapitre 2).

**Questions** : est-ce le bon premier périmètre pour vos concours ? Les phases finales (duels) en
salle sont-elles fréquentes dans vos organisations ? Quelle discipline devrait suivre : TAE,
Campagne/Nature/3D, Beursault ?

## QO-06 — Inscriptions en ligne et paiement

Le dossier prévoit l'enregistrement des inscriptions par l'organisateur (EF-13). L'auto-inscription
en ligne par les archers (voire le paiement des mises en ligne) est une extension possible mais
structurante (comptes publics, sécurité, coûts).

**Questions** : comment recevez-vous les inscriptions aujourd'hui (courriel, formulaire, téléphone) ?
L'auto-inscription en ligne est-elle un besoin réel, et à quel horizon ?

## QO-07 — Volumes et échelle

**Questions** : ordres de grandeur de vos concours (archers par départ, départs par concours,
concours par saison) ? L'application doit-elle servir un seul club ou être mutualisable
(département, plusieurs clubs) ?

## QO-08 — Hébergement et responsabilité

Selon les réponses à QO-02 et QO-06 : application locale (poste du club), auto-hébergée, ou
hébergée en ligne. Le choix emporte des conséquences RGPD (responsable de traitement, sous-traitant,
localisation des données).

**Questions** : le club dispose-t-il déjà d'un hébergement ou d'un prestataire ? Une solution
purement locale (aucune donnée en ligne) serait-elle préférée ?

**Proposition technique** : voir [docs/architecture/stack-technique.md](../architecture/stack-technique.md).
