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

start_playing:
	mgba -5 --savestate Pokemon_Yellow_FRENCH_GBC-HS.sav Pokemon_Yellow_FRENCH_GBC-HS.gbc

start_playing_qt:
	mgba-qt -5 --savestate Pokemon_Yellow_FRENCH_GBC-HS.sav Pokemon_Yellow_FRENCH_GBC-HS.gbc

play:	check_free_slot commit_start start_playing commit_done

check_free_slot:
	git pull
	! git log -1 | grep -q START
	echo "The slot is free. Let's play!"

commit_start:
	echo "START ${USER} commence à `date`, auto commit avec 'make commit_start'" | tee --append whoPlayedWhen.log
	git add whoPlayedWhen.log
	git commit -m "START ${USER} commence, auto commit avec 'make commit_start'"
	git push

commit_done:
	echo "DONE ${USER} termine à `date`, auto commit avec 'make commit_done'" | tee --append whoPlayedWhen.log
	git add whoPlayedWhen.log
	git add Pokemon_Yellow_FRENCH_GBC-HS.sav
	git add screenshots/*.png
	git commit -m "DONE ${USER} termine, auto commit avec 'make commit_done'"
	git push

clean_screenshots:
	cd screenshots/
	exiftool -v2 -fast -overwrite_original_in_place ./*.png
	advpng -z -2 ./*.png
