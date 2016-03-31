git clone https://github.com/jing-tw/OpenStack.git
git checkout --orphan allinone

// Install CentOS
cd;OpenStack
. ./init.sh
<Minimal Installation of CentOS>
<get ip>

// Deploy all-in-one openstack
deploy_allinone.sh <ip>
