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

dnf install python36 gcc python3-devel -y

id roboshop &>>$LOGFILE

if [ $? -ne 0 ]
then
    useradd roboshop &>>$LOGFILE
else
    echo "roboshop user exist"
fi

mkdir /app 

Validate $? "Creating app directory"

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip

Validate $? "Downloading payment code"

cd /app 

Validate $? "Changing directory to app directory"

unzip /tmp/payment.zip

Validate $? "Installing requirements"

pip3.6 install -r requirements.txt

Validate $? "Installing requirements"

#vim /etc/systemd/system/payment.service

systemctl daemon-reload

Validate $? "Reload Payment Daemon service"

systemctl enable payment 

Validate $? "Enabling Payment service"

systemctl start payment

Validate $? "Starting Payment service"

