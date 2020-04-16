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
