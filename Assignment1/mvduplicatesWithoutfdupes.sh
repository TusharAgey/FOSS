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
	num=$(find $src | wc -l)
	find $src > thisisthetestfile
	for (( i=1; i<=$num; i++ ))
	do
		origFile=$(head -$i thisisthetestfile | tail -1)
		if [ -f $origFile ]
		then
			file1=$(cat $origFile)
			for (( j=1; j<$num; j++ ))
			do
				otherFile=$(head -$j thisisthetestfile | tail -1)
				if [ $j -ne $i ] && [ -f $otherFile ]
				then
					file2=$(cat $otherFile)
					if [ "$file1" = "$file2" ]
					then
						echo $otherFile
						#now just move the $otherFile to $dest/$otherFile
						#where otherFile is the file with the Directory
						#required hierarchy.
					fi
				fi
			done
		fi
	done

else
	echo "The source directory does not exist."
fi
rm thisisthetestfile