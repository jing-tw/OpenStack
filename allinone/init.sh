#!/bin/bash

iso_file=~/test/allinone/CentOS-7-x86_64-Everything-1511.iso
vm_name=os-node1

# Create vm with memory 4096, nic1: nat, nic2: hostonly, vboxnet1s
VBoxManage createvm --name ${vm_name} --ostype RedHat_64 --register
VBoxManage modifyvm ${vm_name} --memory 4096 --nic1 nat --nic2 hostonly --hostonlyadapter2 vboxnet1

# Setup cdrom and mount the iso
VBoxManage storagectl ${vm_name} --name "IDE Controller" --add ide --controller PIIX4 --hostiocache on --bootable on
VBoxManage storageattach ${vm_name} --storagectl "IDE Controller" --type dvddrive --port 0 --device 0 --medium ${iso_file}

# Add a 10GB disk
VBoxManage storagectl ${vm_name} --name "SATA Controller" --add sata --controller IntelAHCI --hostiocache on --bootable on
VBoxManage createhd --filename OS-${vm_name}.vdi --size 10240
VBoxManage storageattach ${vm_name} --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium OS-${vm_name}.vdi

VBoxManage startvm ${vm_name} --type gui
