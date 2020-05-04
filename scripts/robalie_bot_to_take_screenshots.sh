#!/usr/bin/env bash
#
# Script bash faire des captures d'écran automatiquement
#
# Voir https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/issues/19
#

# XXX Initialisation
type notify-send && notify-send "Lancement de Robalie, le bot qui prend des captures d'écran de la partie en cours à ma place"
echo "Lancement de Robalie, le bot qui prend des captures d'écran de la partie en cours à ma place..."

if type xdotool > /dev/null 2>/dev/null; then
       echo "xdotool est bien installé"
else
       echo "xdotool n'est pas installé, regardez https://www.semicomplete.com/projects/xdotool/"
       exit 1
fi


# XXX Vérification avant de jouer
echo git pull
# if { git log -1 | grep -q START; }; then
#        exit 2
# fi


echo "The slot is free. Let's play!"


# XXX lancement du jeu
make start_playing &

WID=`xdotool search "mGBA" | head -1`
xdotool windowactivate --sync $WID

# XXX script pour simuler un appui d'une touche
# http://wiki.linuxquestions.org/wiki/List_of_keysyms
function hit_this_key () {
       sleep 1
       xdotool windowactivate --sync $WID
       xdotool key --clearmodifiers $1
       echo "La touche $* a été simulée..."
}
function hit_these_keys () {
       sleep 1
       xdotool windowactivate --sync $WID
       xdotool key --clearmodifiers --delay 1000 $*
       echo "Les touches $* ont été simulées..."
}

if type xfce4-screenshooter > /dev/null 2>/dev/null; then
       echo "xfce4-screenshooter est bien installé"
       function do_screenshot () {
              xfce4-screenshooter --delay 1 --window --save $*
       }
else
       echo "xfce4-screenshooter n'est pas installé, on essaie avec gnome-screenshot"
       if type gnome-screenshoot > /dev/null 2>/dev/null; then
              echo "gnome-screenshoot est bien installé"
              function do_screenshot () {
                     gnome-screenshoot --delay=1 --window --save $*
              }
       else
              echo "gnome-screenshoot n'est pas installé, essayez avec 'sudo apt install gnome-screenshoot'"
              exit 3
       fi
fi

declare -i numero_derniere_sauvegarde
numero_derniere_sauvegarde=$(find ./screenshots*/Pokemon_Yellow_FRENCH_GBC-HS-* | grep -o 'Pokemon_Yellow_FRENCH_GBC-HS-.*' | sed s/'Pokemon_Yellow_FRENCH_GBC-HS-'/''/g | sed s/'.png'/''/g | sort -n | tail -n1)

# Lance le jeu
echo "Ouvrer la fenêtre de mGBA"
sleep 1

hit_these_keys x x x x x
# Capture d'écran position
numero_derniere_sauvegarde+=1
echo do_screenshot screenshots/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
# do_screenshot screenshots/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png

# Capture d'écran pokedex
read  # pause
hit_these_keys Return x
numero_derniere_sauvegarde+=1
echo do_screenshot screenshots_pokedex/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
# do_screenshot screenshots_pokedex/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
hit_these_keys w w

# Capture d'écran teams
read  # pause
hit_these_keys Return Down x
numero_derniere_sauvegarde+=1
echo do_screenshot screenshots_teams/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
# do_screenshot screenshots_teams/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
hit_these_keys w w

# Capture d'écran maps
read  # pause
hit_these_keys Return Down x x x
numero_derniere_sauvegarde+=1
echo do_screenshot screenshots_maps/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
# do_screenshot screenshots_maps/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
hit_these_keys w w w

# Capture d'écran badges
read  # pause
hit_these_keys Return Down x
numero_derniere_sauvegarde+=1
echo do_screenshot screenshots_badges/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
# do_screenshot screenshots_badges/Pokemon_Yellow_FRENCH_GBC-HS-${numero_derniere_sauvegarde}.png
hit_these_keys w

# XXX conclusion
echo git add screenshots*/*.png
echo git commit -m "DONE `whoami` termine, auto commit avec 'make commit_done'`./scripts/zenity_script_to_enter_summary.sh`" || git commit -m "DONE `whoami` termine, auto commit avec 'make commit_done'"
echo git checkout -- Pokemon_Yellow_FRENCH_GBC-HS.sav
echo git push

pkill mgba
echo "Terminé pour cette fois, regardez https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/commits/ pour voir le dernier commit avec des captures d'écrans"