#!/bin/bash
if [ $# -eq 1 ]
then
	for (( i=1; i<=$1; i++ ))
	do
		dd if=/dev/zero of=/tmp/file$i bs=1k count=$i #create file(i) of (i) kb
	done
else
	echo "Usage:- ./createfiles.sh Num_Of_Files"
fi