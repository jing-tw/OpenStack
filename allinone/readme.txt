### A: (OpenStack Only) Install OpenStack on VM ###
deploy_allinone.sh <ip>


### B: (All in One) 1. create vm  2. install openstack ###
git clone https://github.com/jing-tw/OpenStack.git
git checkout --orphan allinone

// Install CentOS
cd;OpenStack
. ./init.sh
<Minimal Installation of CentOS>
<get ip>

// Deploy all-in-one openstack
deploy_allinone.sh <ip>




Detail:
Google doc: https://docs.google.com/document/d/1WWYngMsnP2sF-uKENHjuixn2VnjshSECzlu8jcumjJc/edit?usp=sharing
