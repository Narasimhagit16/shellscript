#!/bin/bash

SOURCE_FILE="/etc/passwd"

if [ -f $SOURCE_FILE ]
then
    echo "file does not c "
    exit 1

fi

while IFS= ":" read -r user passwd uid git usefullname homelocation  bashlocation
do
    echo "User: $user
    echo Password:$passwd"
    echo "uid: $uid"

done < $SOURCE_FILE

