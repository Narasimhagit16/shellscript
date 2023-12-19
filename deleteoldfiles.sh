#!/bin/bash
SOURCE_DIR="/tmp/shell-logs"

if [ ! -d $SOURCE_DIR ]
then
    echo "Directory doesnot exist"
    exit 1
else
    echo "Directory  exist"
if

FILES_TO_DELETE=$( find $SOURCE_DIR -type f -mtime +14 -name "*.log" )

while IFS= read -r line
do
    echo "Deleting file: $line"
    rm -rf $line
    
done <<<$FILES_TO_DELETE



