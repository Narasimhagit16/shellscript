#!/bin/bash

SOURCE_DIR="/tmp/shell-logfiles"

mkdir -p $SOURCE_DIR

cd /$SOURCE_DIR

touch -t  202004050000 temp20200405.log
touch -t  202204050000 temp20220405.log
touch -t  202304050000 temp20230405.log

touch -t  202312180000 temp20231218.log
touch -t  202312150000 temp20231215.log
touch -t  202312190000 temp20231201.log

if [ ! -d $SOURCE_DIR ]
then 
    echo " Directory doent exist"
    exit 1
fi

FILES_TO_DELETE=$( find $SOURCE_DIR -type f -mtime +14 -name "*.log" )

while IFS= read -r line
do
    echo "file to be deleted: $line"
    rm -rf $line

done <<<$FILES_TO_DELETE



