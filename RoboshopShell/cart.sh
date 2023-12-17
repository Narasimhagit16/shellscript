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

curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>>$LOGFILE

Validate $? "Downloding cart code"

cd /app &>>$LOGFILE

Validate $? "Changing directory to app directory"

unzip -o /tmp/cart.zip &>>$LOGFILE

Validate $? "Unizipping cart code"

npm install &>>$LOGFILE

Validate $? "Resolve the dependencies using npm"

#vim /etc/systemd/system/cart.service

cp /home/centos/shellscript/RoboshopShell/cart.service /etc/systemd/system/cart.service &>>$LOGFILE

Validate $? "Copying cart service"

systemctl daemon-reload &>>$LOGFILE

Validate $? "Reload the daemon"

systemctl enable cart &>>$LOGFILE

Validate $? "Enabling cart service"

systemctl start cart &>>$LOGFILE

Validate $? "Starting cart service"