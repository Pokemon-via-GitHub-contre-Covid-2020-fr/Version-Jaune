# Makefile to send this page to Zam
SHELL=/usr/bin/env /bin/bash

all:	send
send:	send_zamok
send_zamok:
	CP --exclude=.git ./ ${Szam}publis/Pokemon-via-GitHub-contre-Covid-2020-fr.github.io/
send_ovh:
	CP --exclude=.git ./ ${Fovh}publis/Pokemon-via-GitHub-contre-Covid-2020-fr.github.io/

check_metadata:	check_file check_md5sum check_dub

check_file:
	file Pokemon_Yellow_FRENCH_GBC-HS.gbc
	cat Pokemon_Yellow_FRENCH_GBC-HS.gbc.file
check_md5sum:
	md5sum Pokemon_Yellow_FRENCH_GBC-HS.gbc
	cat Pokemon_Yellow_FRENCH_GBC-HS.gbc.md5sum
check_dub:
	du -b Pokemon_Yellow_FRENCH_GBC-HS.gbc
	cat Pokemon_Yellow_FRENCH_GBC-HS.gbc.dub

play:
	mgba -5 Pokemon_Yellow_FRENCH_GBC-HS.gbc

commit_start:
	echo "START $(whoami) commence à $(date), auto commit avec 'make commit_start'" | tee --append whoPlayedWhen.log
	git add whoPlayedWhen.log
	git commit -m "START $(whoami) commence, auto commit avec 'make commit_start'"

commit_done:
	git add Pokemon_Yellow_FRENCH_GBC-HS.sav
	cd screenshots/
	exiftool -v2 -fast -overwrite_original_in_place ./*.png
	advpng -z -2 ./*.png
	git add ./*.png
	git commit -m "DONE $(whoami) termine, auto commit avec 'make commit_start'"
