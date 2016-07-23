# OpenStack 
## allinone branch
### Step 1: pull the code
```bash
git clone https://github.com/jing-tw/OpenStack.git
cd OpenStack
git checkout allinone
```
### Step 2: OpenStack Version Check
Check the Openstack version that you want to install for the variable OpenStack_RPM_File in allinone/allinone.sh.


### Step 3: Deploy OpenStack (vagrant version)
```bash
vagrant init centos/7
. ./vagrant_sh.sh
```
### Verification (OpenStack Client)
```bash
ssh (Control Node}
sudo su  # as root
. ./keystonerc_admin
nova image-list
```

### Detail
Google doc: https://docs.google.com/document/d/1WWYngMsnP2sF-uKENHjuixn2VnjshSECzlu8jcumjJc/edit?usp=sharing
