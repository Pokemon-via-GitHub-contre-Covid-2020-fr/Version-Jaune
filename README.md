# Pokémon Jaune - Pokemon-via-GitHub-contre-Covid-2020-fr

[Sur ce dépôt git](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune), nous allons stocker les sauvegardes et captures d'écran de notre première partie de Pokémon Jaune, suivant les idées présentées dans [ce projet "Pokemon-via-GitHub-contre-Covid-2020-fr"](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/).

<img align="right" width="50%" src="logos/Pokemon_via_GitHub_logo_HD.png" alt="Logo, Pokemon_via_GitHub_logo_HD.png">

> Auteur : [Lilian Besson (@Naereen)](https://github.com/Naereen/), inspiré librement par [Twitch plays Pokémon](https://fr.wikipedia.org/wiki/Twitch_Plays_Pok%C3%A9mon).

---

# Discord

Venez discuter sur [ce serveur Discord](https://discord.gg/xEpj7D) ! Dans le canal **"Version Jaune"**.

# Foire aux questions

## Comment jouer ?
Il faut suivre les instructions suivantes :

1. Créer un compte GitHub, ajouter [une étoile au projet](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/stargazers) (ou au [méta projet](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Pokemon-via-GitHub-contre-Covid-2020-fr.github.io)). Je vous invite à devenir membre de l'organisation, puis [il vous faut éditer ce fichier](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Pokemon-via-GitHub-contre-Covid-2020-fr.github.io/blob/master/whois.md) sans faire de fusio-demande (= *pull request*).

2. Télécharger un émulateur, **je recommande mGBA** ou Visual Boy Advance, **sur un ordinateur** et pas un téléphone,

3. Télécharger la ROM, vérifier que c'est la bonne en vérifiant [sa somme `md5sum`](Pokemon_Yellow_FRENCH_GBC-HS.gbc.md5sum), [son nombre de bits](Pokemon_Yellow_FRENCH_GBC-HS.gbc.md5sum) (et les informations renvoyées par [`file Pokemon_Yellow_FRENCH_GBC-HS.gbc`](Pokemon_Yellow_FRENCH_GBC-HS.gbc.md5sum) dans un terminal sous GNU/Linux). Regarder [ce ticket](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/issues/1) si vous avez du mal à télécharger la ROM.

4. [Cloner le dépôt](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune), et vérifier que vous pouvez lancer le jeu, et charger la sauvegarde. Vérifier que vous pouvez sauvegarder, puis ensuite prenez l'habitude de lancer une session de jeu avec `make play`, qui automatise l'algorithme de gestion de conflit de jeux (cf. explications ci-dessous).

## Avec le `Makefile`

Une fois le dépôt cloné, si vous êtes sous GNU/Linux ou Mac OS, le [fichier `Makefile`](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/blob/master/Makefile) donne quelques commandes pour automatiser certaines choses :

- `make metadata` permet de vérifier que la ROM `Pokemon_Yellow_FRENCH_GBC-HS.gbc` téléchargée est la bonne ;
- `make start_playing` permet de commencer à jouer avec mGBA,
- `make play` automatise l'algorithme de gestion de jeu :
   1. vérifier que personne n'est en train de jouer (avec `make check_free_slot`),
   2. écrire et envoyer un commit disant que le joueur actuel est en train de jouer (ie, un commit dont le message commence par `"START user ..."`) (avec `make commit_start`),
   3. lance mGBA sur la sauvegarde actuelle (avec `make start_playing`),
   4. quand mGBA se ferme, ajoute dans un commit git la nouvelle sauvegarde, et les captures d'écran (de position réelle, des badges, de position sur la carte, et de l'équipe actuelle), et envoie un commit de fin de session (ie, un commit dont le message commence par `"DONE user ..."`_) (avec `make commit_done`).

---

# Questions à propos du jeu

## Qui est en train de jouer ?
> Il faut regarder [l'auteur du dernier commit](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/commits/master), qui a commencé sa session de jeu avec un commit dont le message commence par `"START ..."`.

**Personne** ne joue actuellement.

> La ligne précédente est normalement [mise à jour automatiquement](update_readme_start.sh).

## Qui joue ensuite ?
- Il n'y a pas et *il n'y aura pas* de mécanisme de file d'attente : dès que le joueur courant arrête, c'est-à-dire qu'elle a terminé sa session de jeu (avec un commit dont le message commence par `"END ..."`), n'importe qui peut venir jouer et prendre le relai !

- Essayez de gérer cela intelligemment, et ne soyez pas trop pressé : si vous vous abonnez [au flux RSS](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/commits/master.atom) du projet, vous pouvez recevoir des notifications ou des mails quand un joueur commence et termine sa session.

  > Moi je vais le faire, au moins au début, pour vérifier que le projet ne part pas en cacahuètes.

- Donc je me répète : pas de mécanisme de file d'attente, et on reste calme et pas trop réactif pour éviter les bogues !

## Qui a joué quand ?
> Il faut regarder [l'historique des commits](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/commits/master). Vous pouvez aussi consulter [ce fichier `whoPlayedWhen.log`](whoPlayedWhen.log).

Dernière ligne de l'historique :

- Edouard Leurent (3 minutes ago) : DONE eleur termine, auto commit avec 'make commit_done' (commit f6ca096) ;
- Edouard Leurent (20 minutes ago) : START eleur commence, auto commit avec 'make commit_start' (commit ab24ae1) ;
- Remi100fa1000 (14 hours ago) : DONE remib termine, auto commit avec 'make commit_done' (commit d7c9381) ;
- Remi100fa1000 (14 hours ago) : START remib commence, auto commit avec 'make commit_start' (commit ec54f8d) ;
- Lilian Besson (15 hours ago) : DONE lilian termine, auto commit avec 'make commit_done' (commit a12d397) ;
- Lilian Besson (15 hours ago) : START lilian commence, auto commit avec 'make commit_start' (commit 22da759) ;
- Edouard Leurent (16 hours ago) : DONE  termine, auto commit avec 'make commit_done' (commit f79bbca) ;
- Edouard Leurent (16 hours ago) : START  commence, auto commit avec 'make commit_start' (commit 95cba29) ;
- Lilian Besson (24 hours ago) : DONE lilian termine, auto commit avec 'make commit_done' (commit 336da34) ;
- Lilian Besson (24 hours ago) : START lilian commence, auto commit avec 'make commit_start' (commit 3390a96) ;

> La ligne précédente est normalement [mise à jour automatiquement](update_readme_done.sh).

## Dernière question ?
- [Posez une question](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/issues/new) en ouvrant un ticket.

---

# Où en est-on dans l'aventure ?
- On a terminé le jeu : Ligue Pokémon battue le vendredi 15 mai, Mewtwo capturé le samedi 16 mai.

## Où est-on dans le jeu ?
- [Regardez dans ce dossier](screenshots/)
  > Il faut juste montrer où on se trouve le héros dans le monde extérieur.

<img width="50%" src="gifs/world.gif" alt="GIF de l'équipe Pokémon évoluant au cours du temps">

## Quelle est l'équipe actuelle ?
- [Regardez dans ce dossier](screenshots_teams/)

<img width="50%" src="gifs/teams.gif" alt="GIF de l'équipe Pokémon évoluant au cours du temps">

## Où en est-on dans la progression du Pokédex
- [Regardez dans ce dossier](screenshots_pokedex/)
  > Il faut juste montrer *le menu avec le Pokédex*.

<img width="50%" src="gifs/pokedex.gif" alt="GIF de l'équipe Pokémon évoluant au cours du temps">

## Où en est-on dans la progression des badges ?
- [Regardez dans ce dossier](screenshots_badges/)
  > Il faut juste montrer *le menu avec les badges et l'argent*.

<img width="50%" src="gifs/badges.gif" alt="GIF de l'équipe Pokémon évoluant au cours du temps">

## Où est-on sur la carte ?
- [Regardez dans ce dossier](screenshots_maps/)
  > Il faut juste montrer où on se trouve le héros *sur la carte*.

<img width="50%" src="gifs/maps.gif" alt="GIF de l'équipe Pokémon évoluant au cours du temps">

---

## :scroll: License ? [![GitHub license](https://img.shields.io/github/license/Pokemon-via-GitHub-contre-Covid-2020-fr/meta.svg)](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/meta/blob/master/LICENSE)
MIT Licensed (file [LICENSE](LICENSE)).
© [Lilian Besson](https://GitHub.com/Naereen) et [contributeurs et contributrices](https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/graphs/contributors), 2020.

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Pokemon-via-GitHub-contre-Covid-2020-fr/meta/graphs/commit-activity)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://GitHub.com/Naereen/ama)
[![Analytics](https://ga-beacon.appspot.com/UA-38514290-17/github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/meta/README.md?pixel)](https://GitHub.com/Pokemon-via-GitHub-contre-Covid-2020-fr/meta/)
[![ForTheBadge built-with-love](http://ForTheBadge.com/images/badges/built-with-love.svg)](https://GitHub.com/Naereen/)
[![ForTheBadge uses-badges](http://ForTheBadge.com/images/badges/uses-badges.svg)](http://ForTheBadge.com)
[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)
