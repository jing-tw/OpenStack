#/bin/bash
subnet=`ip r | grep default | cut -d ' ' -f 3|awk -F '[.]' '{printf "%s.%s.%s.\n",$1,$2,$3}'`

HostNameArray=($(vboxmanage list runningvms |cut -d" " -f 1))
IPArray=($(vboxmanage list runningvms | sed -r 's/.*\{(.*)\}/\1/' | xargs -L1 -I {} vboxmanage guestproperty enumerate {} | grep "Net.*V4.*IP" | grep $subnet | awk -F '[, \" \" ]' '{print $5}'))

for (( i=0; i<${#HostNameArray[@]}; i++)); do
   echo "${HostNameArray[i]} => ${IPArray[i]} "
   echo "==>  . ./deploy_allinone.sh ${IPArray[i]}"
   if [ -z "${IPArray[i]}" ]; then
    echo "No running VM or no VirutalBox Guest Additional Package installed."
   fi
done
