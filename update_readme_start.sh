#!/usr/bin/env bash
#
# Script bash pour mettre à jour le fichier README.md pour afficher quel est le joueur actuel.
#


echo "Qui joue actuellement ?"
author="**Personne** ne joue actuellement."
if ( git log -1 | grep -q START ); then
    author="**$(git log -1 --pretty=format:'%an')** joue actuellement."
fi
echo "$author"

sed -i.backup s/"^.*joue actuellement.$"/"$author"/g README.md
diff README.md README.md.backup
read
trash README.md.backup
git diff README.md README.md.backup

echo "Qui a joué quand ?"
git log --oneline --graph --pretty=format:'%h - %d %s (%cr) <%an>' --abbrev-commit --date=relative | grep "\(START\|DONE\)" | tail -n6
