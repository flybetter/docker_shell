#!/bin/bash
#echo
echo "第一个参数：$1";
for((i=3;i<=$1;i++));
do
echo `docker run -p 192.168.1.$i:161:161/udp -itd centos6-jdk7-simulator java -jar /home/AESimular_6_23.jar CXNK1010101$i  192.168.1.242 744GE 10.7.0.25 192.168.1.$i`;
#sleep 1m
done
