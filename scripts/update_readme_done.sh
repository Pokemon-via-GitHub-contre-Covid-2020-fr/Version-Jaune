#!/usr/bin/env bash
#
# Script bash pour mettre à jour le fichier README.md pour afficher quels sont les derniers joueurs.
#
echo "Qui a joué quand ?"
playlog=$( git log --oneline --pretty=format:'- %an (%cr) :%d %s (commit %h) ;' --abbrev-commit --date=relative | sed s/'* -'/'-'/ | grep "\(START\|DONE\)" | head -n10 )

# 2nd part, update the log of last players
begin="Dernière ligne de l'historique :"
end="> La ligne précédente est normalement"
perl -0777 -pi -e "s/$begin.*?$end/$begin\n\n$playlog\n\n$end/sg;" README.md
