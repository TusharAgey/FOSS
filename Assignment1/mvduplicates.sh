#!/bin/bash
if [ $# -ne 2 ]
then
	echo "Usage: ./mvduplicates.sh src_folder dest_folder"
	exit 1
fi
i=0
src=$1 #the folder to be scanned for duplicates,
dest=$2 #the folder to store duplicates.
if [ -d "$src" ]
then
	fdupes -fr "$src" > /tmp/thisisthetestfile #these are duplicate files
	flen=$(cat /tmp/thisisthetestfile | wc -l)
	for (( i=1; i<$flen; i++ ))
	do
		process=$(head -$i /tmp/thisisthetestfile | tail -1) #The file to be moved
		tar -czvf file$i.tar.gz "$process" #Compress to preserve the directory structure
		mv file$i.tar.gz $dest/ #move to the destination directory
		tar -xsvf $dest/file$i.tar.gz -C $dest #Decompress
		rm "$process" #Delete the file from original location
		rm $dest/file$i.tar.gz #Delete the .tar.gz that were created
	done
	
else
	echo "The source or destination directory does not exist."
fi
