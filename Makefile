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

pokemonsay:
	pokemonsay "Let's play Pokémon" || cowsay "Let's play Pokémon"

start_playing: pokemonsay
	mgba -6 --savestate Pokemon_Yellow_FRENCH_GBC-HS.sav Pokemon_Yellow_FRENCH_GBC-HS.gbc

start_playing_mgba:
	mgba -6 --savestate Pokemon_Yellow_FRENCH_GBC-HS.sav Pokemon_Yellow_FRENCH_GBC-HS.gbc

start_playing_mgba_old:
	mgba -6 Pokemon_Yellow_FRENCH_GBC-HS.gbc

start_playing_qt:
	mgba-qt -6 --savestate Pokemon_Yellow_FRENCH_GBC-HS.sav Pokemon_Yellow_FRENCH_GBC-HS.gbc

start_playing_vba:
	vba --video-4x Pokemon_Yellow_FRENCH_GBC-HS.gbc

play:	check_free_slot commit_start start_playing commit_done
play_mgba:	check_free_slot commit_start start_playing_mgba commit_done
play_vba:	check_free_slot commit_start start_playing_vba commit_done

check_free_slot:
	git pull
	! git log -1 | grep -q START
	echo "The slot is free. Let's play!"

commit_start:
	# ./scripts/zenity_script_to_validate_start.sh
	echo "START `whoami` commence à `date`, auto commit avec 'make commit_start'" | tee --append whoPlayedWhen.log
	./scripts/update_readme_start.sh
	git add whoPlayedWhen.log README.md
	git commit -m "START `whoami` commence, auto commit avec 'make commit_start'"
	git push

commit_done:
	./scripts/zenity_script_to_validate_end.sh
	echo "DONE `whoami` termine à `date`, auto commit avec 'make commit_done'" | tee --append whoPlayedWhen.log
	./scripts/update_readme_done.sh
	git add whoPlayedWhen.log README.md
	git add Pokemon_Yellow_FRENCH_GBC-HS.sav
	git add screenshots*/*.png
	git commit -m "DONE `whoami` termine, auto commit avec 'make commit_done'`./scripts/zenity_script_to_enter_summary.sh`" || git commit -m "DONE `whoami` termine, auto commit avec 'make commit_done'"
	git push


clean_screenshots:
	# first screenshots of in game moments
	exiftool -v2 -fast -overwrite_original_in_place ./screenshots/*.png
	advpng -z -2 ./screenshots/*.png
	# then badges
	exiftool -v2 -fast -overwrite_original_in_place ./screenshots_badges/*.png
	advpng -z -2 ./screenshots_badges/*.png
	# then maps
	exiftool -v2 -fast -overwrite_original_in_place ./screenshots_maps/*.png
	advpng -z -2 ./screenshots_maps/*.png
	# and then teams
	exiftool -v2 -fast -overwrite_original_in_place ./screenshots_teams/*.png
	advpng -z -2 ./screenshots_teams/*.png
