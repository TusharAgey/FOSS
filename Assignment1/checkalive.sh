#!/bin/bash
if [ $# -le 0 ] || [ $(echo $1 | wc -c) -le 4 ]
then
	echo "Usage: ./checkalive.sh IP1 IP2...IPn. See Readme for more information"
	exit 1
fi 
len=$(echo $1 | tr -cd "." | wc -c)
lenth=$#
if [ $len -eq 3 ] #The IP's are given explicitly
then
	for(( i=0; i<$lenth; i++ ))
	do
		if [ $(ping -c 1 $1 | grep "100% packet loss" | wc -c) -eq 0 ]
		then
			echo $1
		fi
		shift;
	done
else 	#The IP's are given as a range
	for(( i=$2; i<=$3; i++ ))
	do
		ips=$1.$i
		if [ $(ping -c 1 $ips | grep "100% packet loss" | wc -c) -eq 0 ]
		then
			echo $1
		fi
	done
fi