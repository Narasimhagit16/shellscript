#!/bin/bash

SOURCE_DIR="/tmp/shell-logfiles"

mkdir -p $SOURCE_DIR

cd /$SOURCE_DIR

touch -t temp20200405.log 20200405
touch -t temp20220405.log 20220405
touch -t temp20230405.log 20230405

touch -t temp20231218.log 20231218
touch -t temp20231215.log 20231215
touch -t temp20231201.log 20231201

if [ ! -d $SOURCE_DIR ]
then 
    echo " Directory doent exist"
    exit 1
fi

FILES_TO_DELETE=$( find $SOURCE_DIR -type file -mtime +14 -name "*.log" )

while IFS = read -r line
do
    ehco "file to be deleted: $line"
    rm -rf $line

done <<<$FILES_TO_DELETE



