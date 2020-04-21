#!/usr/bin/env bash
#
# Script bash pour mettre à jour le fichier README.md pour afficher quels sont les derniers joueurs.
#
# 2nd part, update the log of last players
#
echo "Qui a joué quand ?"
git log --oneline --graph --pretty=format:'- %an (%cr) :%d %s (commit %h) ;' --abbrev-commit --date=relative | sed s/'* -'/'-'/ | grep "\(START\|DONE\)" | head -n10

echo "TODO find a way to include the last 10 lines of git log."
