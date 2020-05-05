#!/usr/bin/env bash
#
# Script bash faire des captures d'écran automatiquement
#
# Voir https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/issues/19
#
clear
echo "Lancement de Robalie ($0), le bot qui prend des captures d'écran de la partie en cours à ma place..."

# XXX Initialisation
type notify-send > /dev/null 2>/dev/null && \
       notify-send "Lancement de Robalie ($0), le bot qui prend des captures d'écran de la partie en cours à ma place"

if type xdotool > /dev/null 2>/dev/null; then
       echo "xdotool est bien installé"
else
       echo "xdotool n'est pas installé, regardez https://www.semicomplete.com/projects/xdotool/"
       exit 1
fi


# XXX Vérification avant de jouer
git pull
if { git log -1 | grep -q START; }; then
       exit 2
fi

echo "The slot is free. Let's play!"

name="Pokemon_Yellow_FRENCH_GBC-HS"

# XXX lancement du jeu
echo "Lancement de l'émulateur en travail de fond..."
mgba -3 --savestate $name.sav $name.gbc &


echo "Pause de 10 secondes..."
sleep 10

WID=$(xdotool search "mGBA" | head -1)
xdotool windowactivate --sync $WID

function cleanup_sav() {
       echo git checkout -- Pokemon_Yellow_FRENCH_GBC-HS.sav
       git checkout -- Pokemon_Yellow_FRENCH_GBC-HS.sav
       echo pkill mgba
       pkill mgba
}
trap cleanup_sav EXIT
trap cleanup_sav SIGINT

# XXX script pour simuler un appui d'une touche
# http://wiki.linuxquestions.org/wiki/List_of_keysyms
function hit_this_key () {
       sleep 3
       xdotool windowactivate --sync $WID
       xdotool key --clearmodifiers $1
       echo "  La touche $* a été simulée..."
}
function hit_these_keys () {
       echo "  Simulation des touches $* dans trois secondes..."
       sleep 3
       xdotool windowactivate --sync $WID
       xdotool key --clearmodifiers --delay 1000 $*
       echo "  Les touches $* ont été simulées..."
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
numero_derniere_sauvegarde=$(find ./screenshots*/$name-* | grep -o "$name-.*" | sed s/"$name-"/""/g | sed s/".png"/""/g | sort -n | tail -n1)

# Lance le jeu
echo "Ouverture la fenêtre de mGBA et appui de touches simulé..."
sleep 10

hit_these_keys w z w z w z w z x x
sleep 10

hit_these_keys x x
# Capture d'écran position
numero_derniere_sauvegarde+=1
echo do_screenshot "screenshots/${name}-${numero_derniere_sauvegarde}.png"
do_screenshot "screenshots/${name}-${numero_derniere_sauvegarde}.png"
sleep 5


# Capture d'écran pokedex

# echo "Enter to continue ... DEBUG"
# read  # pause

hit_these_keys Return x

numero_derniere_sauvegarde+=1
echo do_screenshot "screenshots_pokedex/${name}-${numero_derniere_sauvegarde}.png"
do_screenshot "screenshots_pokedex/${name}-${numero_derniere_sauvegarde}.png"
hit_these_keys w z w z
sleep 5

# Capture d'écran teams

# echo "Enter to continue ... DEBUG"
# read  # pause

hit_these_keys Return Down x
numero_derniere_sauvegarde+=1
echo do_screenshot "screenshots_teams/${name}-${numero_derniere_sauvegarde}.png"
do_screenshot "screenshots_teams/${name}-${numero_derniere_sauvegarde}.png"
hit_these_keys w z w z
sleep 5

# Capture d'écran maps

# echo "Enter to continue ... DEBUG"
# read  # pause

hit_these_keys Return Down x x x
numero_derniere_sauvegarde+=1
echo do_screenshot "screenshots_maps/${name}-${numero_derniere_sauvegarde}.png"
do_screenshot "screenshots_maps/${name}-${numero_derniere_sauvegarde}.png"
hit_these_keys w z w z w z
sleep 5

# Capture d'écran badges

# echo "Enter to continue ... DEBUG"
# read  # pause

hit_these_keys Return Down x
numero_derniere_sauvegarde+=1
echo do_screenshot "screenshots_badges/${name}-${numero_derniere_sauvegarde}.png"
do_screenshot "screenshots_badges/${name}-${numero_derniere_sauvegarde}.png"
hit_these_keys w z
sleep 5


# XXX conclusion
echo git add 'screenshots*/*.png'
git add screenshots*/*.png

echo git commit -m "DONE `whoami` ($0) termine, auto commit avec 'make commit_done'"
git commit -m "DONE `whoami` ($0) termine, auto commit avec 'make commit_done'"

cleanup_sav

echo git push
git push

echo "Terminé pour cette fois, regardez https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune/commits/ pour voir le dernier commit avec des captures d'écrans"