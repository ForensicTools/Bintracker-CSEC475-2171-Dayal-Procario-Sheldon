#!/bin/bash

#
# This script will first update package indexes, upgrade them to the current
# version, then install and configure Bro.
#

red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m'

# dependencies installs the required Bro dependencies
function dependencies(){
	echo -e "${green}[*] Installing required dependencies${nc}"
	apt-get install bison cmake flex g++ gdb make libmagic-dev libpcap-dev libgeoip-dev libssl-dev python-dev swig zlib1g-dev

	if [$? > 0]
	then
		echo -e "${red}[!!] Could not install dependencies${nc}"
	exit
	else
		echo -e "${green}[+] Dependencies installed!${nc}"
	fi
}

# downloadbro clones Bro from github to then be installed by the installbro function
function downloadbro(){
	echo -e "${green}[*] Cloning BRO IDS${nc}"
	git clone --recursive git://git.bro.org/bro

	if [$? > 0]
		then
		echo -e "${red}[!!] Could not clone BRO${nc}"
		exit
	else
		echo -e "${green}[+] BRO cloned! ${nc}"
	fi
}

# installbro installs necessary files for bro in the bro directory
function installbro(){
	cd bro
	./configure
	make
	make install
	configurebro
}

# configurebro configures Bro globally
function configurebro(){
	echo -e "${green}[*]Configuring BRO globally${nc}"
	echo "export PATH=$PATH:/usr/local/bro/bin" > /etc/profile.d/3rd-party.sh
	source /etc/profile.d/3rd-party.sh
}

# main will call other functions after establishing the current directory
function main(){
	cwd=$(pwd)
	echo -e "${green}[*]Configuring BRO IDS${nc}"
	dependencies
	downloadbro
	installbro
    configurebro
	echo -e "${green}[+]Bro configured${nc}"
}

# Check to make sure user is running as root - this is required!
if [[ $EUID -ne 0 ]]; then
	echo -e "${red}This script must be run as root${nc}"
	exit 1
fi

#Call function main to begin program
main
