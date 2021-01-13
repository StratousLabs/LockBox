#!/bin/bash



#Load Dock/Remove Dir
sudo rm ~/.config/plank/dock1/launchers/*
sudo cp -a /usr/Lockbox-Plank/. ~/.config/plank/dock1/launchers

sudo apt update -y && sudo apt upgrade -y


# UFW Firewall Configs
sudo ufw default deny outgoing
sudo ufw default deny incoming
sudo ufw allow out 53
sudo ufw allow out http
sudo ufw allow out https
sudo ufw enable
sudo service ufw restart


#Clean Logs/Folders
sudo chmod a+rwx ~/.config/plank/dock1/launchers
#find /var/log -type f -delete
sudo rm -rf /usr/Lockbox-Plank/
rm *.dockitem
sudo rm -rf /usr/Post.sh

