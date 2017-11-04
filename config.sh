#!/bin/bash
#config script for bro and cuckoo

red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m'

function dependencies
{
    echo -e "${green}[*] Installing required dependencies${nc}"
    apt-get install cmake make gcc g++ flex bison libpcap-dev libssl-dev   python-dev swig zlib1g-dev
    if [ $? > 0]
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
    git clone https://github.com/bro/bro.git
    if [ $? > 0]
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
    $(dependencies)
    $(downloadbro)
    $(installbro)

}

main
