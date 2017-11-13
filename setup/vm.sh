#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m'

function download
{
    mkdir /srv/isos
    echo -e "${green}[*]Downloading Windows XP ISO${nc}"
    wget -o /srv/isos/cuckoo1.iso http://pcriver1.com/download/pcriver.com_Windows_XP_Pro_SP3_32_bit.iso

}

VBoxManage createvm --name "cuckoo1" --register

VBoxManage modifyvm "cuckoo1" --memory 256 --acpi off --boot1 dvd
VBoxManage modifyvm "cuckoo1" --nic1 hostonly --hostonlyadapter1 vboxnet0
VBoxManage modifyvm "cuckoo1" --ostype WindowsXP

mkdir /srv/vms
VBoxManage createhd --filename /srv/vms/cuckoo1.vdi --size 10000
VBoxManage storagectl "cuckoo1" --name "IDE Controller" --add ide
VBoxManage storageattach "cuckoo1" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium /srv/vms/cuckoo1.vdi

download

VBoxManage storageattach "cuckoo1" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium /srv/vms/cuckoo1.iso
echo -e  "${green}[*]Running Windows VM${nc}"
VBoxManage modifyvm "cuckoo1" --vrde on
if [$?>0]
then
    echo -e "${red}[!]VM FAILED${nc}"
else
    echo -e "${green}[+]VM RUNNING SUCCESSFULLY${nc}"
fi


