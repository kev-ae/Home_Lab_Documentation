#!/bin/bash

# update the repo before installing ntp
apt-get -y update
apt-get -y upgrade

# installing ntp
apt-get -y install ntp

# check if ntp was install correctly
if [ $(sntp --version) == "" ]
then
	echo "Something went wrong with installing ntp"
	exit 1
fi

# removing default pool config and replacing with given pool setting
