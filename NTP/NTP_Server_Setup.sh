#!/bin/bash

# update the repo before installing ntp
apt-get -y update
apt-get -y upgrade

# installing ntp
apt-get -y install ntp

# check if ntp was install correctly
if [ "$(sntp --version)" =~ "sntp" ]
then
	echo "Something went wrong with installing ntp"
	exit 1
fi

# removing default pool config and replacing with given pool setting
if [ -z "$1" ]
then
	echo "You did not include a file for the pool configuration"
	exit 1
else
	sed -i -r '/pool [0-9]\.ubuntu*/d' /etc/ntp.conf
	cat "$1" >> /etc/ntp.conf
fi

# restarting ntp service
service ntp restart

# checking to see if service is running
if [ -z "$(systemctl is-active --quiet ntp)" ]
then
	echo "NTP service has been restarted successfully"
else
	echo "There was an error when restarting the ntp service"
	exit 1
fi

# Configuring firewall to allow client to connect
ufw allow from any to any port 123 proto udp
