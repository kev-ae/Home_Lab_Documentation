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
apt-get -y update
apt-get -y upgrade

# entering server's ip address into config and hostname
 echo "$serverip $hostname" >> /etc/hosts

# check synchronized
echo "Enter CTRL-Z then check for synchronized using command  ntpdate $hostname"
echo "Once you are done, enter fg then push a button to continue script"
read

# disable the systemd timesyncd service
timedatectl set-ntp off

# installing ntp on client
apt-get -y install ntp

# configure ntp config file
echo "server $hostname prefer iburst" >> /etc/ntp.conf

# restart ntp server
service ntp restart

echo "now check queue using command ntpq -ps"
