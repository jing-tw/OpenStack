#!/bin/bash

sudo yum -y update
#sudo yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-kilo/rdo-release-kilo-1.noarch.rpm
sudo yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-liberty/rdo-release-liberty-1.noarch.rpm
sudo yum install -y openstack-packstack
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
sleep 10

sudo packstack --answer-file=${answer_file}
