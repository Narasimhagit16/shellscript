#!/bin/bash

#sh old-logs.sh -s "/tmp/shellscript-logs" -a delete  -t 7 -m 10


User have to provide
Source directory
Action. Either archive or delete
If archive, he must provide destination. If delete no need of destination
Days. How many days old. by default 14 days
Memory. Optional. if user gives consider it otherwise dont consider memory

#sh old-logs.sh -s <source-dir> -a <archive|delete> -d <destination> -t <day> -m <memory-in-mb>
USAGE()
{

    echo " sh old-logs.sh -s <source-dir> -a <archive|delete> -d <destination> -t <day> -m <memory-in-mb>"
    exit 1
}

SOURCE_DIR=$1
ACTION=$2
DAYS_OLD=$3
MEMORY=$4


Validate-DIR(){
    if [ ! -d $SOURCE_DIR ]
    then    
        echo -e "Direcory not exist: $SOURCE_DIR "
        exit 1
    fi
}

Validate-ACTION(){
    if [ $ACTION -ne 'Delete' | $ACTION -ne 'Archive' ]
    then
        echo "Invalid Action provided"
        exit 1
    fi
}

Validate-Days-OLD(){
    if [ $DAYS_OLD -eq 0 ]
    then
        echo "Default days taken is 14"
       
    fi
}


Validate-DIR $SOURCE_DIR
Validate-ACTION $ACTION
Validate-Days-OLD $DAYS_OLD
#Validate-MEMORY $MEMORY


if [ $# -eq 0]
then 
    USAGE
fi

while getopts ":s:a:o:m" opt
do
    case $opt in
        s) 

esac