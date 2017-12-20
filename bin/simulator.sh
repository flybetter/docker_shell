#!/bin/bash
#echo
echo "ip begin：$1 number:$2";
ip=$1
numb=$2
firstdigip=`echo $ip|cut -d"." -f 1`
seconddigip=`echo $ip|cut -d"." -f 2`
thirddigip=`echo $ip|cut -d"." -f 3`
fourthdigip=`echo $ip|cut -d"." -f 4`
for((i=1;i<=$numb;i++));
do

#firstdigip=`echo $ip|cut -d"." -f 1`
#seconddigip=`echo $ip|cut -d"." -f 2`
#thirddigip=`echo $ip|cut -d"." -f 3`
#fourthdigip=`echo $ip|cut -d"." -f 4`
	if [ $fourthdigip -eq 255 ];then
		thirddigip=`expr $thirddigip + 1`
		fourthdigip=1
	else
		fourthdigip=`expr $fourthdigip + 1`
	fi
ip=$firstdigip"."$seconddigip"."$thirddigip"."$fourthdigip
echo $ip >> virtual_ip_added.txt
echo `ifconfig eth1:$i $ip netmask 255.255.0.0 up`;
outid=`expr $i+10000000 `
echo `docker run -p $ip:161:161/udp -p $ip:3000:3000/udp -itd centos6-jdk7-simulator java -jar /home/simulator_7_10.jar CXNK$outid  192.168.1.242 744GE 10.7.0.25 $ip`;
done
