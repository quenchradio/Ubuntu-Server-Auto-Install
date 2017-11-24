#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################


systemctl stop plexmediaserver; sleep 10
chmod 0777 -R /var/lib/plexmediaserver; sleep 10
mkdir -p /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins

Programloc='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins'

echo "Installing CouchPotato"; git clone https://github.com/mikedm139/CouchPotato.bundle.git "$Programloc"/CouchPotato.bundle

echo "Installing Headphones"; git clone https://github.com/willpharaoh/headphones.bundle.git "$Programloc"/Headphones.bundle

echo "Installing SickBeard/SickRage"; git clone https://github.com/mikedm139/SickBeard.bundle.git "$Programloc"/SickBeard.bundle

echo "Installing Speedtest"; git clone https://github.com/Twoure/Speedtest.bundle.git "$Programloc"/Speedtest.bundle

echo "Installing SS-Plex"; git clone https://github.com/mikew/ss-plex.bundle.git "$Programloc"/SS-Plex.bundle

echo "Installing Sub Zero Subtitles"; git clone https://github.com/pannal/Sub-Zero.bundle.git "$Programloc"/Sub-Zero.bundle

echo "Installing WebTools"; git clone https://github.com/ukdtom/WebTools.bundle.git "$Programloc"/WebTools.bundle

chown plex:plex -R /var/lib/plexmediaserver; chmod 0777 -R /var/lib/plexmediaserver; systemctl start plexmediaserver
