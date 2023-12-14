#!/bin.bash

ID=$( id -u )  # get only the id

if [ ID -ne 0]
then
   echo " you are not root user to perform this task"
   exit 1
else 
    echo " You are Root User"
fi

yum install mysql -y

if [ $? -ne 0 ]
then
    echo "MySQL installation is failed"
else
    echo "MySQL installation is success"
fi
