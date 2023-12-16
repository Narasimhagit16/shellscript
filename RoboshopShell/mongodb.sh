#!/bin/bash

ID=$( id -u )

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"





TIMESTAMP=$( date +%F-%H-%M-%S ) 
LOGFILE="/tmp/$0-$TIMESTAMP.log"

if [ $ID -ne 0 ]
then 
    echo "your not ROOT user"
    exit 1
else
    echo "your  ROOT user"
fi

Validate()
{
    if [ $1 -ne 0 ]
    then
        echo -e " $2 is.. $R FAILED $N"
        exit 1
    else
        echo -e " $2 is.. $G SUCCESS $N"
    fi
}

#vim /etc/yum.repos.d/mongo.repo

cp /home/centos/shellscript/RoboshopShell/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOGFILE

yum list insatlled mongodb-org &>>$LOGFILE

if [ $? -ne 0 ]
then
    dnf install mongodb-org -y &>>$LOGFILE
    Validate $? "installing MongoDB"
else
    echo -e "MongoDB already installed..$R SKIPPING $N"
fi

systemctl enable mongod &>>$LOGFILE

Validate $? "Enabling MongoDB"

systemctl start mongod &>>$LOGFILE

Validate $? "starting MongoDB"


sed -i 's/127.0.0.1/0.0.0.0/g'  /etc/mongod.conf &>>$LOGFILE

Validate $? "giving external acces to  MongoDB"

systemctl restart mongod &>>$LOGFILE

Validate $? "restarting MongoDB"

