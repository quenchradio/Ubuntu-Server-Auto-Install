#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/sonarr --gecos "Sonarr Service" --group sonarr

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC

echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list

sudo apt-get update && sudo apt-get install nzbdrone libmono-cli-dev apt-transport-https

sudo chown -R sonarr:sonarr /opt/NzbDrone

#echo "<--- Restoring sonarr Settings --->"
#cat /home/xxxusernamexxx/install/configs/programs/CouchPotato.txt > /opt/CouchPotatoServer/settings.conf

echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/Services/sonarr.service /etc/systemd/system/
chmod 644 /etc/systemd/system/sonarr.service
systemctl enable sonarr.service
systemctl restart sonarr.service
