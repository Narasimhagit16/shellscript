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

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>>$LOGFILE

Validate $? "Downloading Catalogue Application code"

cd /app &>>$LOGFILE

Validate $? "Changing app directory"

unzip -o /tmp/catalogue.zip &>>$LOGFILE

Validate $? "Unzipping Catalogue Application code"

npm install &>>$LOGFILE

Validate $? "Installing dependncies"

#vim /etc/systemd/system/catalogue.service

cp /home/centos/shellscript/RoboshopShell/catalogue.service /etc/systemd/system/catalogue.service

Validate $? "copying catalogue serive"

systemctl daemon-reload &>>$LOGFILE

Validate $? "Reload daemon"

systemctl enable catalogue &>>$LOGFILE

Validate $? "Enabling Catalogue service"

systemctl start catalogue &>>$LOGFILE

Validate $? "Starting Catalogue service"

cp /home/centos/shellscript/RoboshopShell/mongo.repo  /etc/yum.repos.d/mongo.repo &>>$LOGFILE

Validate $? "Copying mongo repo file"

dnf install mongodb-org-shell -y &>>$LOGFILE

Validate $? "Intsalling mongo client"

mongo --host mongodb.nariops.online </app/schema/catalogue.js &>>$LOGFILE

Validate $? "Loading schema into MongoDB"