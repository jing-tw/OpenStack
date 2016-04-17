# OpenStack
## pull the code
```bash
git clone https://github.com/jing-tw/OpenStack.git
cd OpenStack
git checkout allinone
```
## vagrant version
```bash
vagrant init centos/7
. ./vagrant_sh.sh
```


## vboxmanage + pure bash version
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


## Detail:
Google doc: https://docs.google.com/document/d/1WWYngMsnP2sF-uKENHjuixn2VnjshSECzlu8jcumjJc/edit?usp=sharing
