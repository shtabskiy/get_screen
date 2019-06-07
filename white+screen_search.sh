#!/bin/bash
hosts=`cat image`
for i in $hosts
do
ping $i -c 1
if [ $? -eq 0 ]; then
name=`sshpass -p '' ssh -q -o 'UserKnownHostsFile /dev/null' -o 'StrictHostKeyChecking=no' root@$i "hostname"`
sshpass -p '' ssh -q -o 'UserKnownHostsFile /dev/null' -o 'StrictHostKeyChecking=no' root@$i "export DISPLAY=:0"
sshpass -p '' ssh -q -o 'UserKnownHostsFile /dev/null' -o 'StrictHostKeyChecking=no' root@$i "DISPLAY=:0 import -window root /tmp/$name.png"
sshpass -p '' scp -o StrictHostKeyChecking=no root@$i:/tmp/*.png /home/ads/log
else
echo "The host $i is down!"
fi
done

#if [ $? -eq 0 ]; then
#fz=``find /home/ads/log -type f -size -50k -exec ls -S -l -h {} \;
#printf '%s\n' "$fz"
#fi

if [ $? -eq 0 ]; then
find /home/ads/log -type f -size -16k -exec cp {} /home/ads/333/ \;
ls /home/ads/333/ | sed 's/.png//g' >> white_screen.txt
fi
