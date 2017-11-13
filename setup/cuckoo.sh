#!/bin/bash
#config script for cuckoo
#no need to run,will be called
#by main config.sh

red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m'

#install various dependenies
function dependencies
{
    echo -e "${green}[*]Installing cuckoo dependencies${nc}"
    apt-get install python python-pip python-dev libffi-dev libssl-dev python-virtualenv python-setuptools libjpeg-dev zlib1g-dev swig mongodb postgresql libpq-dev qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils python-libvirt

    apt-get install tcpdump apparmor-utils
    aa-disable /usr/sbin/tcpdump
    apt-get install tcpdump
    apt-get install libcap2-bin
    setcap cap_net_raw.cap_net_admin=eip/usr/sbin/tcpdump

    echo -e "${green}[+]Dependencies installed ${nc}"

}
#install virtual box
function vbox
{
    echo -e "${green}[*]Installing virtualbox${nc}"
    cd /tmp
    echo deb http://download.virtualbox.org/virtualbox/debian xenial contrib | tee -a /etc/apt/sources.list.d/virtualbox.list
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
    apt-get update
    apt-get install virtualbox-5.1

    echo -e "${green}[+]VirtualBox installed ${nc}"
}
#add user
function user_add
{
    echo -e "${green}[*]Add Cuckoo user${nc}"
    adduser cuckoo
    usermod -a -G vboxusers cuckoo
    usermod -a -G libvirtd cuckoo
    echo -e "${green}[+]User added${nc}"

}

function install
{
    pip install -U pip setuptools
    pip install -U cuckoo

}

function main
{
    echo -e "${green}[*]Installing cukoo${nc}"
    dependencies
    vbox
    user_add
    install
    echo -e "${green}[+]Cuckoo installed"
}

main
