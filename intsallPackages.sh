#!/bin/bash

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

ID=$( id -u )

if [ $ID -ne 0 ]
then
    echo "you are not root user"
    exit 1
else
    echo "you are root user"
fi

Validate()
{
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILED $N"
        exit 
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi

}

#yum install nginx  -y &>>$LOGFILE

#Validate $? "Installing GIT"

for package in $@
do
    yum list installed $package &>>$LOGFILE
    if [ $? -ne 0 ]
    then
        yum  install $package -y &>>$LOGFILE
        Validate $? "installing $package"
    else
        echo -e " $package already installed.. $Y SKIPPING $N"
    fi
done




