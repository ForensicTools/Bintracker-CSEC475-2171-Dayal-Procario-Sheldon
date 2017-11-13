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
    apt-get install git python python-pip python-dev libffi-dev libssl-dev python-virtualenv python-setuptools libjpeg-dev zlib1g-dev swig mongodb postgresql libpq-dev qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils python-libvirt
    apt-get install python python-pip python-dev python-sqlalchemy python-bson python-dpkt python-jinja2 python-magic python-pymongo python-gridfs python-libvirt python-bottle python-pefile bridge-utils python-pyrex
    pip install jinja2 pymongo bottle pefile cybox maec django chardet

    apt-get install tcpdump apparmor-utils
    aa-disable /usr/sbin/tcpdump
    apt-get install tcpdump
    apt-get install libcap2-bin
    setcap cap_net_raw.cap_net_admin=eip/usr/sbin/tcpdump

    #ssdeep
    wget https://sourceforge.net/projects/ssdeep/files/ssdeep-2.12/ssdeep-2.12.tar.gz
    tar xvzf ssdeep-2.12.tar.gz
    cd ssdeep-2.12/
    ./configure && make && make install
    git clone https://github.com/kbandla/pydeep
    cd pydeep
    python setup.py build
    python setup.py install

    #yara
     wget https://yara-project.googlecode.com/files/yara-1.7.tar.gz
     tar xvzf yara-1.7.tar.gz
     cd yara-1.7/
     ./configure && make && make install
     echo "/usr/local/lib" >> /etc/ld.so.conf
     ldconfig

     wget https://yara-project.googlecode.com/files/yara-python-1.7.tar.gz
     tar xvzf yara-python-1.7.tar.gz
     cd yara-python-1.7/
     python setup.py build
     python setup.py install

     wget https://distorm.googlecode.com/files/distorm3.zip
     unzip distorm3.zip
     cd distorm3/
     python setup.py build
     python setup.py install

     wget https://volatility.googlecode.com/files/volatility-2.3.1.tar.gz
     tar xvzf volatility-2.3.1.tar.g
     cd volatility-2.3.1/
     python setup.py build
     python setup.py install
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
    apt-get install virtualbox

    echo -e "${green}[+]VirtualBox installed ${nc}"
}
#add user

function install
{
    adduser cuckoo
    usermod -G vboxusers cuckoo
    pip install -U pip setuptools
    pip install -U cuckoo
}

function cuckoo_config
{
    VBoxManage hostonlyif create
    ip link set vboxnet0 up
    ip addr add 192.168.56.1/24 dev vboxnet0
}

function main
{
    echo -e "${green}[*]Installing cukoo${nc}"
    dependencies
    vbox
    user_add
    install
    cuckoo_config
    echo -e "${green}[+]Cuckoo installed${nc}"
}

main
