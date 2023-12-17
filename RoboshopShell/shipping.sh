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

dnf install maven -y

id roboshop &>>$LOGFILE

if [ $? -ne 0 ]
then
    useradd roboshop &>>$LOGFILE
else
    echo "roboshop user exist"
fi

mkdir -p /app &>>$LOGFILE

Validate $? "Creating app directory"

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>>$LOGFILE

Validate $? "Downloading Shipping Application code"

cd /app &>>$LOGFILE

Validate $? "Changing app directory"

unzip -o /tmp/shipping.zip &>>$LOGFILE

Validate $? "Unzipping Catalogue Application code"

mvn clean package &>>$LOGFILE

Validate $? "Creating java package"

mv target/shipping-1.0.jar shipping.jar &>>$LOGFILE

Validate $? "Renaming JAR file"

#/etc/systemd/system/shipping.service

cp /home/centos/shellscript/RoboshopShell/shipping.service /etc/systemd/system/shipping.service &>>$LOGFILE

Validate $? "Copying shipping service"

systemctl daemon-reload &>>$LOGFILE

Validate $? "Reload daemon"

systemctl enable shipping  &>>$LOGFILE

Validate $? "Enabling Shipping service"

systemctl start shipping  &>>$LOGFILE

Validate $? "Starting Shipping service"

dnf install mysql -y &>>$LOGFILE

Validate $? "Installing MySQL server"

mysql -h mysql.nariops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>$LOGFILE

Validate $? "Loading Shipping scheema into mysql "

systemctl restart shipping &>>$LOGFILE

Validate $? "re-starting Shipping service"