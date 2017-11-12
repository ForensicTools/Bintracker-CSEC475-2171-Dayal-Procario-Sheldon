#!/bin/bash
#config script for bro and cuckoo

red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m'

function dependencies
{
    echo -e "${green}[*] Installing required dependencies${nc}"
    apt-get install bison cmake flex g++ gdb make libmagic-dev libpcap-dev libgeoip-dev libssl-dev python-dev swig2.0 zlib1g-dev
    if [( $? > 0)]
    then
        echo -e "${red}[!!] Could not install dependencies${nc}"
        exit
    else
        echo -e "${green}[+] Dependencies installed!${nc}"
    fi
}

function downloadbro
{
    cd ~
    echo -e "${green}[*] Cloning BRO IDS${nc}"
    git clone --recursive git://git.bro.org/bro
    if [( $? > 0)]
    then
        echo -e "${red}[!!] Could not clone BRO${nc}"
        exit
    else
        echo -e "${green}[+] BRO cloned! ${nc}"
    fi

}

function installbro
{
    cd bro
    ./configure && make && make install

}


function main
{
    echo -e "${green}[*]Configuring BRO IDS${nc}"
    dependencies
    downloadbro
    installbro
}

main
