#!/usr/bin/env bash
#
# Script bash pour appeler (si disponible) "zenity --question" pour valider le commit.
#

type zenity && { zenity --question \
       --timeout=60 --width=640 --height=440 \
       --title="Pokémon via GitHub contre Covid-19" \
       --text="$(echo -e "Voulez-vous vraiment commiter votre sauvegarde ?\n\n$(ls -larth Pokemon_Yellow_FRENCH_GBC-HS.sav)")" \
; } || echo "Zenity pas trouvé. Regarde https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/issues/14 ?"
