#!/bin/bash

iso_file=~/test/allinone/CentOS-7-x86_64-Everything-1511.iso
vm_name=os-node1-test
manager=vboxmanage   #VBoxManage
storage_size=10240   #10GB
bridge_nic=eth0 #wlan0

# Create vm with memory 4096, nic1: nat, nic2: hostonly, vboxnet1s, nic3: bridged to wlan0
${manager} createvm --name ${vm_name} --ostype RedHat_64 --register
${manager}  modifyvm ${vm_name} --memory 4096 --nic1 nat --nic2 hostonly --hostonlyadapter2 vboxnet1 --nic3 bridged --bridgeadapter3 ${bridge_nic}

# Setup cdrom and mount the iso
${manager}  storagectl ${vm_name} --name "IDE Controller" --add ide --controller PIIX4 --hostiocache on --bootable on
${manager}  storageattach ${vm_name} --storagectl "IDE Controller" --type dvddrive --port 0 --device 0 --medium ${iso_file}

# Add a disk
${manager}  storagectl ${vm_name} --name "SATA Controller" --add sata --controller IntelAHCI --hostiocache on --bootable on
${manager}  createhd --filename OS-${vm_name}.vdi --size ${storage_size}
${manager}  storageattach ${vm_name} --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium OS-${vm_name}.vdi

VBoxManage startvm ${vm_name} --type gui
