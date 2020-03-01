#!/bin/bash

#Sets permissions for website files and directories

#Files and directories to be excluded from permission modifications.
#If the object is deeper than the current working directory, prefix with relative path.
exceptions=(. .. .git README.md scripts scripts/setPermissions.sh scripts/exportWebsite.sh)

#List of files and directories for permission modifications. Currently, this ignores hidden files.

list=( $(find $PWD/*) )
logDate=`date +"%d-%b-%Y-%H:%M:%S"`
logName="permissionLog"
fullLogPath=$PWD/scripts/$logDate$logName.txt
for i in ${list[@]}; do
	isException="false"
	for j in ${exceptions[@]}; do
		if [ "$i" = "$PWD/$j" ];
		then
			isException="true"
		fi
	done

	if [ "$isException" = "false" ];
        then
		if [ -f "$i" ];
		then
			#Set file permissions to 644
			chmod 644 $i
			output="Permissions 644 set for file: $i"
			echo $output >> $fullLogPath
		elif [ -d "$i" ];
		then
			#Set directory permissions to 755
			chmod 755 $i
			output="Permissions 755 set for directory: $i"
			echo $output >> $fullLogPath
		else
			:
		fi
	else
		:
	fi
done
