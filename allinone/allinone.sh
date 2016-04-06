#!/bin/bash

sudo yum -y update
#sudo yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-kilo/rdo-release-kilo-1.noarch.rpm
sudo yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-liberty/rdo-release-liberty-1.noarch.rpm
sudo yum install -y openstack-packstack

# start fixed mongodb server not found issue
sudo yum -y install mongodb-server python-pymongo
cd /etc;rm -f mongodb.conf; touch -f mongod.conf
sudo ln -s /etc/mongod.conf mongodb.conf

# update the answerAIO txt
answer_file=answerAIO.txt
patten=CONFIG_KEYSTONE_SERVICE_NAME
cd; packstack --gen-answer-file ${answer_file} 
sudo sed -i "s#^.*\b${patten}\b.*\$#${patten}=httpd#g" ${answer_file}

# run
echo "run: packstack --answer-file=./answerAIO.txt"
echo 
echo
echo
#sleep 1

sudo packstack --answer-file=${answer_file}


# [fix issue] Issue: Bug 1119920 - http://ip/dashboard 404 from all-in-one rdo install on rhel7

echo "=== Fixing Issue 1119920 http://ip/dashboard 404 error"
target_file=/etc/httpd/conf.d/15-horizon_vhost.conf
patten="ServerAlias localhost"
new_string="    ServerAlias *"
sed -i "s#^.*\b${patten}\b.*\$#${new_string}#g" ${target_file}

service httpd restart

