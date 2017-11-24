#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update
mode="$1"
Programloc=/opt/Muximux
backupdir=/opt/backup/Muximux

case $mode in
	(-i|"")
	echo "Setting up Muximux User"
	adduser --disabled-password --system --home /opt/ProgramData/Muximux --gecos "Muximux Service" --group Muximux
	bash /opt/install/Apache2/Apache2-install.sh
	apt update
	apt install php7.0 php7.0-* openssl libapache2-mod-php7.0 -y
	apt remove php7.0-snmp -y
	echo "Installing Muximux"
	cd /opt && git clone https://github.com/mescon/Muximux.git
	chown -R Muximux:Muximux /opt/Muximux
	chmod -R 0777 /opt/Muximux
	service apache2 restart
	;;
	(-r)
	echo "<--- Restoring Muximux Settings --->"
	echo "Stopping Apache2 for Muximux"
	systemctl stop apache2
	cd /opt/backup
	tar -xvzf /opt/backup/Muximux_Backup.tar.gz
	cp -rf Muximux/ /opt; rm -rf Muximux/
	chown -R Muximux:Muximux /opt/Muximux
	chmod -R 0777 /opt/Muximux
	echo "Restarting up Apache2 for Muximux"
	systemctl restart apache2
	;;
	(-b)
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Muximux to /opt/backup"
	cp -rf /opt/Muximux/ $backupdir
	cd $backupdir
    	tar -zcvf /opt/backup/Muximux_Backup.tar.gz *
	rm -rf $backupdir
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Muximux not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Muximux to Update"
	sleep 5
	cd $Programloc
	git pull
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Muximux not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Muximux to Force Update"
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	;;
    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	echo "-u for Update"
	echo "-U for Force Update"
	exit 0;;
esac
exit 0
