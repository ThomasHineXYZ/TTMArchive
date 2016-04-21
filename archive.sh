#!/bin/bash

archiveInFolder="in"
archiveOutFolder="out"
logFile="convert.log"
fileTypeArray=("mp4" "m2ts" "avi")

echo "Started @ $(echo $(date))" >> ${logFile}

for file in `ls ${archiveInFolder}/`
do
	filename=$(basename "$file")
	extension="${filename##*.}"
	filename="${filename%.*}"
	echo "$filename.$extension" >> ${logFile}
	if [[ " ${fileTypeArray[@]} " =~ " ${extension,,} " ]]; then
		echo "Running" >> ${logFile}
		HandBrakeCLI -v -i "${archiveInFolder}/${filename}.${extension}" -o "${archiveOutFolder}/${filename}-x265.mp4" -e x265 -q 20 -E copy:aac -B auto
	else
		echo "Skipping" >> ${logFile}
	fi
done
echo "Finished @ $(echo $(date))" >> ${logFile}
echo "" >> ${logFile}