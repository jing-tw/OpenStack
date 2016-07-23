# Deploy OpenStack using packstack

## Step 1: Pull the code
```bash
git clone https://github.com/jing-tw/OpenStack.git
cd OpenStack
git checkout allinone
```

## Step 2: OpenStack Version Check
Please check the Openstack version that you want to install for the variable OpenStack_RPM_File in allinone/allinone.sh.
### (a) Deploy OpenStsack using vagrant
```bash
vagrant init centos/7
. ./vagrant_sh.sh
```


### (b) vboxmanage + pure bash version
== Scenario A: Deploy OpenStack on a existed VM ==
```bash
tool-get-vm-ip.sh          # get the target vm instance ip
deploy_allinone.sh <ip>    # deploy OpenStack to the vm
```

== Scenario B: Auto-Create VM + Deploy OpenStack on that VM ==
```bash
cd OpenStack
. ./init-vm.sh     # create a empty vm (nic0: bridge + nic1: host-only, 200GB
                   # install OS
. ./tool-get-vm-ip.sh          # get the target vm instance ip
deploy_allinone.sh <ip>    # deploy OpenStack to the vm
```
### Verification (OpenStack Client)
```bash
ssh (Control Node}
sudo su  # as root
. ./keystonerc_admin
nova image-list
```

## Detail:
Google doc: https://docs.google.com/document/d/1WWYngMsnP2sF-uKENHjuixn2VnjshSECzlu8jcumjJc/edit?usp=sharing
