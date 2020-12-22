#!/bin/bash

# disable ssh and stop the service if it exists

if [ systemctl is-enabled sshd && systemctl is-active sshd ] 
then 
	sudo systemctl disable --now sshd
fi

# install syslog-ng (sshguard dependency)
sudo apt install syslog-ng-core

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

# install sshguard
#sudo apt install sshguard

# disable ping
sudo echo "net.ipv4.icmp_echo_ignore_all = 1" >> /etc/sysctl.d/11-disableping.conf
sudo sysctl -p /etc/sysctl.d/11-disableping.conf


