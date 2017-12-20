#!/bin/bash
FileName=virtual_ip_added.txt
for i in `cat $FileName`
do 
echo `ip addr del $i dev ens192`
wait
done

echo `rm -rf $FileName`

echo `docker stop $(docker ps -a -q)`

echo `docker rm $(docker ps -a -q)`
