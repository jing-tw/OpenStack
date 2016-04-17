#!/bin/bash

# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function timer()
{
    if [[ $# -eq 0 ]]; then
        echo $(date '+%s')
    else
        local  stime=$1
        etime=$(date '+%s')

        if [[ -z "$stime" ]]; then stime=$etime; fi

        dt=$((etime - stime))
        ds=$((dt % 60))
        dm=$(((dt / 60) % 60))
        dh=$((dt / 3600))
        printf '%d:%02d:%02d' $dh $dm $ds
    fi
}

tmr=$(timer)

strIP=$1
valid_ip $strIP
if [[ $? -eq 0 ]]
then
    echo "ip checked ok"
    #ssh -t root@$strIP "$(< allinone.sh)"
    defalut_gateway_subnet=`ip r | grep default | cut -d ' ' -f 3|awk -F '[.]' '{printf "%s.%s.%s.\n",$1,$2,$3}'`
    ssh root@$strIP "bash -s" -- < ./allinone.sh "$defalut_gateway_subnet"
else
    echo "Error:  Invalid IP address: $strIP"
    echo "Usage: . ./deploy_allinone.sh IPv4 address"
fi

echo "Elapsed time:$(timer $tmr)"

