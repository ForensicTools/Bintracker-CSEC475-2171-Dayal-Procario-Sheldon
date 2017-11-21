#!/bin/bash

#
# This script will run the other scripts associated with the Bintracker tool.
#

#Check if user is root
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 
	exit 1
fi

#Check that user has entered a .pcap or .pcapng file for use
[ -z $1 ] && echo "Network capture required" && exit 1

#Check that user has entered their API key for use
[ -z $2 ] && echo "API key required" && exit 1

#Run scripts
bro -r $1 extract-all.bro
python md5-ify.py $2
python scan_check.py $2
python json_handler.py

