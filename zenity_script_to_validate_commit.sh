#!/usr/bin/env bash

zenity --question \
       --timeout=60 --width=640 --height=440 \
       --title="Pokémon via GitHub contre Covid-19" \
       --text="$(echo -e "Voulez-vous vraiment commiter votre sauvegarde ?\n\n$(ls -larth Pokemon_Yellow_FRENCH_GBC-HS.sav)")"
