
#echo
echo "ip begin：$1 number:$2  begin eth1:$3  begin outid:$4";
ip=$1
numb=$2
default=$3
defaultoutid=$4
echo $#
if [ $# -ne  4 ];then
        echo "Usage     : sh simulatorUp.sh <starting virtual ip> <number> <eth:number> <outid>"
        echo "eg        : sh simulaotr.sh 192.167.2.0  2  1 10000000"
        exit 1
else
        echo "Msg       : Correct Input parameter"
fi

#cxnk=`expr $4 * 10000000`
firstdigip=`echo $ip|cut -d"." -f 1`
seconddigip=`echo $ip|cut -d"." -f 2`
thirddigip=`echo $ip|cut -d"." -f 3`
fourthdigip=`echo $ip|cut -d"." -f 4`
echo " " > recode.txt
for((i=1;i<=$numb;i++));
do
echo "devicenumber $i "
echo "start time `date "+%Y-%m-%d %H:%M:%S"`"
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
ethip=`expr $default + $i`
#echo "$ethip"
echo `ifconfig ens192:$ethip $ip netmask 255.255.0.0 up`;
outid=`expr $i + $defaultoutid `
#echo `ulimit -HSn 4096`
dockerid=$(docker run -m 20M  -p $ip:161:161/udp -p $ip:3000:3000/udp -itd  centos6-jdk7-simulator-traceroute java -server -Xms5m -Xmx5m -XX:+DisableExplicitGC -XX:+UseParallelGC   -jar /home/simulator_7_10.jar CXNK$outid  192.167.1.242 744GE 10.70.25 $ip)
echo "dockerid $dockerid"
#log=`docker logs $dockerid`
while true
do
log=`docker logs $dockerid`
#echo "$log"
result=$(echo $log | grep "successfully")
if [[ "$result" != "" ]]
then
#    echo "包含"
    break	
else
#    echo "不包含"
    sleep 1
    continue	
fi		
done

#echo `docker run -m 20M  -p $ip:161:161/udp -p $ip:3000:3000/udp -itd centos6-jdk7-simulator-traceroute java  -jar /home/simulator_7_10.jar CXNK$outid  192.167.1.242 744GE 10.7.0.25 $ip`;
echo "devicenumber:$i ">> recode.txt
echo `free -m` >> recode.txt
echo "end time `date "+%Y-%m-%d %H:%M:%S"`"
#sleep 5
done
