#!/usr/bin/env bash
#
# Script bash pour appeler (si disponible) "zenity --entry" pour éditer le message de commit.
#
# Ces deux lignes vides sont là pour faire un joli message de commit, comme cela :
#
# DONE lilian termine, auto commit avec 'make commit_done'
#
# J'ai entraîné l'équipe, battu le rival, et on est dans l'arène de Pierre

echo -e "\n\n"

type zenity && { zenity --entry \
       --timeout=60 --width=640 --height=440 \
       --title="Pokémon via GitHub contre Covid-19" \
       --entry-text="J'ai capturé tel Pokémon, j'ai battu tel dresseur, j'ai découvert tel endroit..." \
       --text="Raconte ta session de jeu en quelques lignes maximum :" \
; } || echo "Zenity pas trouvé. Regarde https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/issues/14 ?"
