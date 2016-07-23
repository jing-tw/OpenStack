#!/bin/bash

function fun_install_package(){

	OpenStack_RPM_File=https://repos.fedorapeople.org/repos/openstack/openstack-mitaka/rdo-release-mitaka-5.noarch.rpm

	yum -y update
	yum install -y ${OpenStack_RPM_File}
	yum install -y openstack-packstack
}

function fun_fix_issue(){
	echo "Start fixed mongodb server not found issue."
	yum -y install mongodb-server python-pymongo
	cd /etc;rm -f mongodb.conf; touch -f mongod.conf
	ln -s /etc/mongod.conf mongodb.conf
}

function fun_update_Answerfile(){
        local strSubNet=$1 #"192.168.0"

        local answer_file="answerAIO.txt"

        packstack --gen-answer-file ${answer_file}

    # change public network to from NAT network to Bridge network
        fun_setup_public_network $strSubNet

    # update the answerAIO txt
	patten=CONFIG_KEYSTONE_SERVICE_NAME
	sed -i "s#^.*\b${patten}\b.*\$#${patten}=httpd#g" ${answer_file}

	# new option
	patten=CONFIG_MANILA_INSTALL
	sed -i "s#^.*\b${patten}\b.*\$#${patten}=y#g" ${answer_file}

	patten=CONFIG_HEAT_INSTALL
	sed -i "s#^.*\b${patten}\b.*\$#${patten}=y#g" ${answer_file}

	patten=CONFIG_KEYSTONE_ADMIN_PW
	sed -i "s#^.*\b${patten}\b.*\$#${patten}=admin#g" ${answer_file}
}

function fun_setup_public_network(){
    strSubNet=$1
    strOldIP=`cat answerAIO.txt | grep CONFIG_CONTROLLER_HOST | awk -F '[=]' '{print $2}'`
    if [ -z "${strOldIP}" ] || [ -z "${strSubNet}" ]; then
            echo "Error: strOldIP=null.;     "
            return;
    fi

    # get the bridged ip
    strBridgedIP=$(ip addr | grep ${strSubNet} | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
    echo strOldIP=$strOldIP
    echo strBridgedIP=$strBridgedIP

    if [ -z "${strBridgedIP}" ]; then
            echo "Error: strBridgedIP=null.;     "
            echo "Use default value (nic0)"
            return;
    fi

    sed -i "s/${strOldIP}/${strBridgedIP}/g" answerAIO.txt
    echo "Success: Switch to BridgeIP: $strBridgedIP"
}

function main_depoly_OpenStack(){
	echo 
	echo
	echo
	echo "run: packstack --answer-file=./answerAIO.txt"
	echo 
	echo
	echo
	#sleep 1
        packstack --answer-file="answerAIO.txt"
}

fun_post_fix_issue(){
	# [fix issue] Issue: Bug 1119920 - http://ip/dashboard 404 from all-in-one rdo install on rhel7

	echo "=== Fixing Issue 1119920 ..."
	target_file=/etc/httpd/conf.d/15-horizon_vhost.conf
	patten="ServerAlias localhost"
	new_string="    ServerAlias *"
	sed -i "s#^.*\b${patten}\b.*\$#${new_string}#g" ${target_file}

	service httpd restart
}


MY_Deault_Gateway_Subnet=$1

fun_install_package
fun_fix_issue

# deploy to bridge network
fun_update_Answerfile $MY_Deault_Gateway_Subnet 
main_depoly_OpenStack 
fun_post_fix_issue





