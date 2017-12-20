#!/bin/bash
FileName=virtual_ip_added.txt
for i in `cat $FileName`
do 
echo `ip addr del $i dev eth1`
done

echo `rm -rf $FileName`
