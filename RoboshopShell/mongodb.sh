#!/bin/bash

ID=$( id -u )

R="\e[31m"
G="\e[32m"
Y="\e[33m"
G="\e[0m"

TIMESTAMP=$date +%F-%H-%M-%S
LOGFILE="/tmp/$0-$TIMESTAMP.log"

if [ $ID -ne 0 ]
then 
    echo "your not ROOT user"
    exit 1
else
    echo "your not ROOT user"
fi

Validate()
{
    if [ $1 -ne 0 ]
    then
        echo " $2 is.. $R FAILED $N"
        exit 1
    else
        echo " $2 is.. $G SUCCESS $N"
    fi
}

#vim /etc/yum.repos.d/mongo.repo

cp /home/centos/shellscript/RoboshopShell/mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-org -y &>>$LOGFILE

Validate $1 "installing MongoDB"

systemctl enable mongod &>>$LOGFILE

Validate $1 "Enabling MongoDB"

systemctl start mongod &>>$LOGFILE

Validate $1 "starting MongoDB"


sed -i '/127.0.0.1/0.0.0.0/g'  /etc/mongod.conf &>>$LOGFILE

Validate $1 "giving external acces to  MongoDB"

systemctl restart mongod &>>$LOGFILE

Validate $1 "restarting MongoDB"

