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


dnf module disable nodejs -y &>>$LOGFILE

Validate $? "Disable current nodeJS version"

dnf module enable nodejs:18 -y &>>$LOGFILE

Validate $? "enabile nodeJS version18"

dnf install nodejs -y &>>$LOGFILE

Validate $? "Installing nodeJS"

id roboshop &>>$LOGFILE

if [ $? -ne 0 ]
then
    useradd roboshop &>>$LOGFILE
else
    echo "roboshop user exist"
fi


mkdir -p /app &>>$LOGFILE

Validate $? "Creating app directory"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip

Validate $? "Unzipping user appliaction"

cd /app &>>$LOGFILE


Validate $? "Change directory to app"

npm install &>>$LOGFILE

Validate $? "Resolving dependencies using npm"

#vim /etc/systemd/system/user.service

systemctl daemon-reload &>>$LOGFILE

Validate $? "Reload daemon"

systemctl enable user &>>$LOGFILE

Validate $? "Enable user appliaction"

systemctl start user &>>$LOGFILE

Validate $? "starting user application"

#vim /etc/yum.repos.d/mongo.repo :: it is already there, no need to create again, just use it
cp /home/centos/shellscript/RoboshopShell/mongo.repo  /etc/yum.repos.d/mongo.repo &>>$LOGFILE

dnf install mongodb-org-shell -y &>>$LOGFILE

Validate $? "installing mongo DB client"

mongo --host mongodb.nariops.online </app/schema/user.js &>>$LOGFILE

Validate $? "Loading user Schema"

