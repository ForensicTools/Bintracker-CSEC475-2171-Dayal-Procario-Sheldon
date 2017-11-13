#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m'

function download
{
    mkdir /srv/isos
    echo -e "${green}[*]Downloading Windows XP ISO${nc}"
    wget -o /srv/isos/windowscuckoo.iso http://pcriver1.com/download/pcriver.com_Windows_XP_Pro_SP3_32_bit.iso

}

VBoxManage createvm --name "Windowscuckoo" --register

VBoxManage modifyvm "Windowscuckoo" --memory 256 --acpi off --boot1 dvd
VBoxManage modifyvm "Windowscuckoo" --nic1 hostonly --hostonlyadapter1 vboxnet0
VBoxManage modifyvm "Windowscuckoo" --ostype WindowsXP

mkdir /srv/vms
VBoxManage createhd --filename /srv/vms/windowscuckoo.vdi --size 10000
VBoxManage storagectl "Windowscuckoo" --name "IDE Controller" --add ide
VBoxManage storageattach "Windowscuckoo" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium /srv/vms/windowscuckoo.vd1

download

VBoxManage storageattach "Windowscuckoo" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium /srv/vms/windowscuckoo.iso
echo -e  "${green}[*]Running Windows VM${nc}"
VBoxManage modifyvm "Windowscuckoo" --vrde on
if [$?>0]
then
    echo -e "${red}[!]VM FAILED${nc}"
else
    echo -e "${green}[+]VM RUNNING SUCCESSFULLY${nc}"
fi


