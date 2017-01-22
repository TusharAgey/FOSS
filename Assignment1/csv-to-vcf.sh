#!/bin/bash
if [ -f $2 ]
then
	echo "The destination file already exists!"
	exit 1
fi
if [ $# -eq 2 ] && [ -f $1 ]
then
	len=$(cat $1 | wc -l)
	arr1=($(cat $1 | tr -d '"' | awk -F',' '{print $1}')) #get array of First Name
	arr2=($(cat $1 | tr -d '"' | awk -F',' '{print $2}')) #get array of Last Name
	arr3=($(cat $1 | tr -d '"' | awk -F',' '{print $3}')) #get array of Mobile Number
	arr4=($(cat $1 | tr -d '"' | awk -F',' '{print $4}')) #get array of emails
	#extracted each column,
	for(( i=0; i<len; i++ ))
	do
		echo "BEGIN:VCARD" >> $2
		echo "VERSION:2.1" >> $2
		echo "N:${arr2[$i]};${arr1[$i]};;;" >> $2
		echo "FN:${arr1[$i]}" >> $2
		echo "TEL;CELL:+91${arr3[$i]}" >> $2
		echo "EMAIL;HOME:${arr4[$i]}" >> $2
		echo "END:VCARD" >> $2

	done
else
	echo "Usage:- ./csv-to-vcf.sh .csv_file .vcf_file"
fi