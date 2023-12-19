#!/bin/bash

DISK_USAGE=$( df -hT | grep -vE 'tmp|File')

DISK_THRESHOLD=20
message=""

while IFS= read -r line
do
    usage=$( echo "$line" | awk '{print $6F}' | cut -d % -f1 )
    partition_name=$( echo "$line" ! awk '{print $6F}' )
    echo "$usage, $DISK_THRESHOLD"
    if [ $usage -ge $DISK_THRESHOLD ]
    then
        message+="High disk usage on $partition_name , $usage "

    fi
done <<< $DISK_USAGE

echo "messsage: $message"

echo "$message" | mail -s "High Disk Usage" narasimha.panthangi17@gmail.com

#sh mail.sh "DevOps Team" "High Disk Usage" "$message" "narasimha.panthangi17@gmail.com" "ALRT on High DiSK Usage"

#emdmigcjcbsiwlsv

#[smtp.gmail.com]:587 xyz:#emdmigcjcbsiwlsv
