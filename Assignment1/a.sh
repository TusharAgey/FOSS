#!/bin/bash
if [ $# -ne 2 ]
then
	echo "Usage: ./mvduplicates.sh src_folder dest_folder"
	exit 1
fi
src=$1 #the folder to be scanned for duplicates,
dest=$2 #the folder to store duplicates.
if [ -d $src ]
then
	
else
	echo "The source folder does not exist."
fi