#!/usr/bin/env bash
#
# Script bash pour appeler (si disponible) "zenity --question" pour valider le commit de fin de jeu.
#

type zenity >/dev/null && { \
zenity --question \
       --timeout=60 --width=340 --height=200 \
       --title="Pokémon via GitHub contre Covid-19" \
       --text="$(echo -e "Voulez-vous vraiment continuer le jeu depuis cette sauvegarde ?\n\n$(file Pokemon_Yellow_FRENCH_GBC-HS.sav)\n$(ls -larth Pokemon_Yellow_FRENCH_GBC-HS.sav)")" \
; } || echo "Zenity pas trouvé. Regarde https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/issues/14 ?"
