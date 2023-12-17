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

dnf install python36 gcc python3-devel -y &>>$LOGFILE

id roboshop &>>$LOGFILE

if [ $? -ne 0 ]
then
    useradd roboshop &>>$LOGFILE
else
    echo "roboshop user exist"
fi

mkdir -p /app &>>$LOGFILE

Validate $? "Creating app directory"

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>>$LOGFILE

Validate $? "Downloading payment code"

cd /app &>>$LOGFILE

Validate $? "Changing directory to app directory"

unzip -o /tmp/payment.zip &>>$LOGFILE

Validate $? "Installing requirements"

pip3.6 install -r requirements.txt &>>$LOGFILE

Validate $? "Installing requirements"

#vim /etc/systemd/system/payment.service
cp  /home/centos/shellscript/RoboshopShell/payment.service  /etc/systemd/system/payment.service &>>$LOGFILE

Validate $? "Copying payment service"

systemctl daemon-reload &>>$LOGFILE

Validate $? "Reload Payment Daemon service"

systemctl enable payment &>>$LOGFILE

Validate $? "Enabling Payment service"

systemctl start payment &>>$LOGFILE

Validate $? "Starting Payment service"

