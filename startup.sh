#!/bin/bash


sudo apt update -y && sudo apt upgrade -y

# disable ssh and stop the service if it exists

if [ systemctl is-enabled sshd && systemctl is-active sshd ] 
then 
	sudo systemctl disable --now sshd
fi

# install syslog-ng (sshguard dependency)
sudo apt install -y syslog-ng-core

# v2
#cat << EOF > syslog-ng.v2.conf
## pass only entries with auth+authpriv facilities from programs other than sshguard
#filter sshlogs { facility(auth, authpriv) and not match("sshguard"); };
## pass to this process with this template (avoids &lt;ID&gt; prefixes)
#destination sshguardproc {
#program("/usr/local/sbin/sshguard"
#template("$DATE $FULLHOST $MESSAGE\n"));
#};
#log { source(src); filter(sshlogs); destination(sshguardproc); };
#EOF

# v3
#cat << EOF >
## enable 3.x mode
#@version:3.0
#
## pass only entries with auth+authpriv facilities from programs other than sshguard
#filter f_sshguard { facility(auth, authpriv) and not program("sshguard"); };
## pass entries built with this format
#destination sshguard {
#program("/usr/sbin/sshguard"
#template("$DATE $FULLHOST $MSGHDR$MESSAGE\n")
#);
#};
#log { source(src); filter(f_sshguard); destination(sshguard); };
#EOF

#Install gnome disk utility
sudo apt-get install -y gnome-disk-utility

#Install GUFW
sudo apt-get install -y gufw

# UFW Firewall Configs
sudo ufw default deny outgoing
sudo ufw default deny incoming
sudo ufw allow out 53
sudo ufw allow out http
sudo ufw allow out https
sudo ufw enable
sudo service ufw restart



#Install Borg Backup
sudo apt-get install -y borgbackup

#Flatpack Download & Vorta Backup
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub com.borgbase.Vorta

#install Telegram
sudo flatpak install -y org.telegram.desktop

#Gnome Feeds
sudo flatpak install flathub org.gabmus.gfeeds



# disable ping
sudo echo "net.ipv4.icmp_echo_ignore_all = 1" >> /etc/sysctl.d/11-disableping.conf
sudo sysctl -p /etc/sysctl.d/11-disableping.conf

# install chrome
curl -sSLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable_current_amd64.deb

#install Firefox
sudo apt-get install -y firefox

# install brave
sudo apt install -y apt-transport-https curl gnupg

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add 
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update && sudo apt install -y brave-browser

# install lastpass

# install metamask

# install exodus wallet
sudo curl -sSLO https://downloads.exodus.io/releases/exodus_20.12.18_amd64.deb
sudo apt install -y ./exodus_20.12.18_amd64.deb
rm -rf exodus_20.12.18_amd64.deb

# install atomic wallet
sudo curl -sSLO https://get.atomicwallet.io/download/atomicwallet.deb
sudo apt install -y ./atomicwallet.deb
rm -rf atomicwallet.deb

# install Bitcoin core


#disable CUPS service
systemctl disable cups-browsed
systemctl disable cups.service

#Remove Elementary OS Camera app
sudo apt remove io.elementary.camera



