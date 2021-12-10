#!/bin/bash

# check for value ip address
if ! [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
then
	echo "Invalid NTP Server's IP Address"
	exit 1
fi

serverip=$1

# check for host name
if [ "$2" == "" ]
then
	hostname="NTP-server-host"
else
	hostname="$2"
fi

# update repo
sudo apt-get update
sudo apt-get upgrade

# entering server's ip address into config and hostname
sudo echo "$serverip $hostname" >> /etc/hosts

# check synchronized
echo "Enter CTRL-Z then check for synchronized using command sudo ntpdate $hostname"
echo "Once you are done, enter fg then push a button to continue script"
read

# disable the systemd timesyncd service
sudo timedatectl set-ntp off

# installing ntp on client
sudo apt-get install ntp

# configure ntp config file
sudo echo "server $hostname prefer iburst" >> /etc/ntp.conf

# restart ntp server
sudo service ntp restart

echo "now check queue using command ntpq -ps"
