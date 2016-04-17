vagrant version
# create environment
vagrant init centos/7

# start deployment
. ./vagrant_sh.sh



vboxmanage + pure bash version
# pull the code
git clone https://github.com/jing-tw/OpenStack.git
git checkout --orphan allinone

== Scenario A: Deploy OpenStack on a existed VM ==
tool-get-vm-ip.sh          # get the target vm instance ip
deploy_allinone.sh <ip>    # deploy OpenStack to the vm

== Scenario B: Auto-Create VM + Deploy OpenStack on that VM ==
# create and install general centos vm
cd OpenStack
. ./init-vm.sh     # create a empty vm (nic0: bridge + nic1: host-only, 200GB
                   # install OS
# deploy OpenStack
tool-get-vm-ip.sh          # get the target vm instance ip
deploy_allinone.sh <ip>    # deploy OpenStack to the vm



Detail:
Google doc: https://docs.google.com/document/d/1WWYngMsnP2sF-uKENHjuixn2VnjshSECzlu8jcumjJc/edit?usp=sharing
