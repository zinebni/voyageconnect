# Rapport VoyageConnect - Projet Java EE

## Description

Ce dossier contient le rapport complet du projet **VoyageConnect**, une plateforme web de réservation de voyages développée en Java EE.

## Structure du rapport

Le rapport est organisé en plusieurs fichiers LaTeX :

- `rapport_voyageconnect.tex` - **Fichier principal** à compiler
- `01_introduction.tex` - Introduction générale
- `02_chapitre1.tex` - Chapitre 1 : Problématique et contexte (État de l'art)
- `03_chapitre2_partie1.tex` - Chapitre 2 Partie 1 : Méthodologie (Analyse + Diagrammes UML)
- `04_chapitre2_partie2.tex` - Chapitre 2 Partie 2 : Méthodologie (BD + Développement + Tests)
- `05_chapitre3.tex` - Chapitre 3 : Réalisation technique
- `06_conclusion.tex` - Conclusion et Bibliographie

## Contenu du rapport

### Front Matter
- Page de garde avec informations du projet
- Remerciements
- Résumé (français)
- Abstract (anglais)
- Table des matières
- Liste des figures
- Liste des tableaux

### Chapitres

#### Introduction
- Contexte général
- Problématique
- Objectifs du projet
- Structure du rapport

#### Chapitre 1 : Problématique et contexte
- État de l'art des technologies Java EE
- Étude comparative des plateformes de réservation
- Analyse des besoins fonctionnels et non-fonctionnels
- Définition du périmètre du projet

#### Chapitre 2 : Méthodologie
- Analyse des besoins détaillée
- Architecture MVC
- **5 Diagrammes UML complets** :
  - Diagramme de cas d'utilisation (acteurs User/Admin)
  - Diagramme de classes (9 entités avec attributs et opérations)
  - Diagramme de séquence : Authentification (12 étapes)
  - Diagramme de séquence : Recherche de vols (11 étapes)
  - Diagramme de séquence : Réservation atomique avec paiement (19 étapes)
- Modélisation de la base de données (schéma relationnel, tables, contraintes)
- Choix technologiques justifiés
- Organisation du code source
- Gestion des transactions JPA
- Sécurité (sessions, filtres, hachage)
- Stratégie de tests

#### Chapitre 3 : Réalisation technique
- Configuration de l'environnement de développement
- Architecture détaillée des couches (Modèle, DAO, Service, Contrôleur)
- Description des fonctionnalités implémentées :
  - Gestion des utilisateurs (inscription, connexion, profil)
  - Recherche multicritère de services (vols, hôtels, circuits)
  - Système de réservation transactionnel
  - Interface d'administration complète
  - Tableau de bord utilisateur
- Problèmes rencontrés et solutions apportées
- Tests et validation
- Limitations et perspectives d'amélioration

#### Conclusion
- Bilan du projet et objectifs atteints
- Compétences développées (techniques et transversales)
- Difficultés et apprentissages
- Apports du projet
- Perspectives d'évolution (court, moyen, long terme)
- Réflexion personnelle

#### Bibliographie
- Documentation officielle (Java EE, JPA, Hibernate, Tomcat, MySQL, Bootstrap)
- Livres de référence
- Articles et tutoriels
- Ressources en ligne
- Outils et logiciels utilisés

## Compilation du rapport

### Prérequis

Pour compiler ce rapport, vous devez avoir une distribution LaTeX installée :

- **Windows** : [MiKTeX](https://miktex.org/) ou [TeX Live](https://www.tug.org/texlive/)
- **macOS** : [MacTeX](https://www.tug.org/mactex/)
- **Linux** : TeX Live (via gestionnaire de paquets)

### Packages LaTeX requis

Le rapport utilise les packages suivants (installés automatiquement par MiKTeX) :

- `babel` (français)
- `fontenc`, `inputenc` (encodage)
- `geometry` (marges)
- `graphicx` (images)
- `hyperref` (liens hypertextes)
- `xcolor` (couleurs)
- `tikz`, `pgf-umlcd` (diagrammes UML)
- `listings` (code source)
- `algorithm2e` (algorithmes)
- `amsmath`, `amssymb` (mathématiques)
- `fancyhdr` (en-têtes et pieds de page)
- `booktabs`, `tabularx` (tableaux)
- `float` (positionnement des figures)

### Méthode 1 : Ligne de commande

```bash
# Se placer dans le dossier rapport/
cd rapport

# Compiler avec pdflatex (exécuter 2 fois pour les références)
pdflatex rapport_voyageconnect.tex
pdflatex rapport_voyageconnect.tex

# Le PDF généré : rapport_voyageconnect.pdf
```

### Méthode 2 : Éditeur LaTeX

#### Avec TeXstudio (recommandé)

1. Télécharger et installer [TeXstudio](https://www.texstudio.org/)
2. Ouvrir `rapport_voyageconnect.tex`
3. Cliquer sur le bouton "Build & View" (F5)

#### Avec Overleaf (en ligne)

1. Créer un compte sur [Overleaf](https://www.overleaf.com/)
2. Créer un nouveau projet vide
3. Uploader tous les fichiers `.tex`
4. Définir `rapport_voyageconnect.tex` comme fichier principal
5. Compiler (automatique)

### Méthode 3 : VS Code

1. Installer l'extension **LaTeX Workshop**
2. Ouvrir `rapport_voyageconnect.tex`
3. Sauvegarder le fichier (Ctrl+S) → compilation automatique
4. Visualiser le PDF dans VS Code

## Problèmes courants

### Package manquant

Si vous obtenez une erreur de package manquant :

- **MiKTeX** : Accepter l'installation automatique lors de la compilation
- **TeX Live** : Installer manuellement via `tlmgr install <nom-package>`

### Erreurs de compilation

- **Erreur de syntaxe** : Vérifier les accolades `{}` et caractères spéciaux (`$`, `%`, `&`, `_`)
- **Caractères accentués** : S'assurer que les fichiers sont encodés en UTF-8
- **Références non résolues** : Compiler 2 fois pour mettre à jour les références croisées

### Diagrammes UML ne s'affichent pas

Les diagrammes utilisent TikZ et pgf-umlcd. Si problème :

```bash
# Installer les packages manquants
tlmgr install pgf
tlmgr install pgf-umlcd
```

## Statistiques du rapport

- **Nombre de pages** : ~80-100 pages (selon configuration)
- **Nombre de figures** : 5+ (diagrammes UML)
- **Nombre de tableaux** : 15+
- **Nombre de sections** : 50+
- **Lignes de code LaTeX** : ~2500 lignes

## Diagrammes UML inclus

Le rapport contient des diagrammes UML professionnels générés avec TikZ :

1. **Diagramme d'architecture MVC** : Représentation de la séparation des couches
2. **Diagramme de cas d'utilisation** : 2 acteurs (User, Admin), 15+ cas d'utilisation
3. **Diagramme de classes** : 8 entités principales avec attributs, opérations et relations
4. **Diagramme de séquence - Authentification** : 12 messages, vérification BCrypt
5. **Diagramme de séquence - Recherche** : 11 messages, requête SQL
6. **Diagramme de séquence - Réservation atomique** : 19 messages, transaction ACID

Tous les diagrammes sont en haute qualité vectorielle (PDF) et peuvent être exportés séparément.

## Personnalisation

Pour adapter le rapport à votre établissement :

1. Ouvrir `rapport_voyageconnect.tex`
2. Modifier la section "Page de garde" (lignes 105-145) :
   - Nom de l'établissement
   - Département/Filière
   - Nom de l'étudiant
   - Encadrant
   - Année académique
3. Recompiler

## Licence

Ce rapport est fourni à des fins éducatives. Les diagrammes et le contenu peuvent être réutilisés avec attribution.

## Contact

Pour toute question concernant ce rapport ou le projet VoyageConnect :

- Email : [votre.email@domaine.com]
- GitHub : [lien-vers-repo]

---

**Dernière mise à jour** : Janvier 2025  
**Version** : 1.0  
**Format** : LaTeX (pdfLaTeX)
