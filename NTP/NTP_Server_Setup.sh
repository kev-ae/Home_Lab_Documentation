#!/bin/bash

# update the repo before installing ntp
sudo apt-get update
sudo apt-get upgrade

# installing ntp
sudo apt-get install ntp

# check if ntp was install correctly
if [ $(sntp --version) == "" ]
then
	echo "Something went wrong with installing ntp"
	exit 1
fi

# removing default pool config and replacing with given pool setting
