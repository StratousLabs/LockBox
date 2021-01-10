#!/bin/bash

# UFW Firewall Configs
sudo ufw default deny outgoing
sudo ufw default deny incoming
sudo ufw allow out 53
sudo ufw allow out http
sudo ufw allow out https
sudo ufw enable
sudo service ufw restart


#Load Dock/Remove Dir
sudo rm ~/.config/plank/dock1/launchers/*
sudo cp -a /usr/LockBox/. ~/.config/plank/dock1/launchers
rm -rf /usr/LockBox/

#Adjust Wallpaper
sudo gsettings set org.gnome.desktop.background picture-uri "file:// ~usr/share/backgrounds/LOCKBOX WALLPAPER-01.jpg"
