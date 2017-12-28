# Projet de Médiathèque 


## introduction

Ce document contient les étapes que j’ai suivis lors de la realisation de ce projet, il s'agit d'un mini-projet qui représente la gestion d'une médiathèque.
À l'aide de language PL-SQL on a pu réaliser ce projet qui permet en premier temps de faire un modele relationnel et puis faire un modele OBJET pour gérer les différents composants, et communiquer entre eux.

- [Partie 1: Model Conceptuel de donnees](#partie1)
  - [MCD](#mcd)
- [Partie 2]
  - [Organisation des fichiers et Ordre d'execution]
  - []



# partie 1
## MCD
On a commencer par realiser le modèle conceptuel des données (MCD), c'est une représentation graphique et structurée des informations 

```SQL
Mediatheque
  ::topTenAuteurs
  ::topTenOeuvres
  ::topTenGenres
  ::oeuvreDisponibilite(Oeuvre)

Oeuvre_type
  sauvegarder
  supprimer
  getAuthor
  getGenre
  getExemplaires
  ::getOeuvre(id)

Emprunt_type
  sauvegarder
  supprimer
  ::creerEmprunt(Oeuvre, Abonnee)
  ::getEmprunt(id)

Exemplaire_type
  sauvegarder
  supprimer
  getOeuvre
  estDisponible

Author_type
  sauvegarder
  supprimer
  getOeuvres
  ::getAuthor(id)

Abonnee_type
  sauvegarder
  supprimer
  estAboonee
  ::getAbonnee

Abonnement_type
  sauvegarder
  supprimer
  ::creerAbonnement(abonnee)
```

![alt Médiathèque image 1](https://raw.githubusercontent.com/belarfaoui-zakaria/psql/master/pictures/2.png)