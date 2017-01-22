#!/bin/bash
function adjust_time () { #For fixing the time
	val=$(expr $1 - 1 )
	if [ $val -eq 4 ]
	then
		echo -n "00:0"
		 
	elif [ $val -eq 5 ]
	then
		echo -n "00:"
	elif [ $val -eq 7 ]
	then
		echo -n "0"
	fi
}

if [ $# -eq 1 ]
then
	num=1 #current line is start time or subtitle. 1=start time, 2=subtitle
	lines=$(cat $1 | wc -l) #count number of lines
	(( lines++ )) #for last line
	echo $lines
	for(( i=1; i<=lines; i++ )) #process each line
	do
		line=$(cat $1 | head -$i | tail -1) #get the current line
		if [ $num -eq 1 ]
		then
			echo $i #print subtitle number
			adjust_time $(echo $line | wc -c) #making the time in the format of hh:mm:ss
			echo -n $line",100" #printing the actual time
			echo -n " --> " #printing the arror
			line=$(cat $1 | head -$(expr $i + 2) | tail -1) #get the third line(this contains the end time!)
			adjust_time $(echo $line | wc -c)
			echo $line",100"
			num=2
		else
			echo -e $line"\n"
			num=1
		fi
		
	done
else
	echo "Please provide a transcript file"
fi