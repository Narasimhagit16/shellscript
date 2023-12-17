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

mkdir -p /app

Validate $? "Creating app directory"

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip

Validate $? "Downloading Shipping Application code"

cd /app

Validate $? "Changing app directory"

unzip -o /tmp/shipping.zip

Validate $? "Unzipping Catalogue Application code"

mvn clean package

Validate $? "Creating java package"

mv target/shipping-1.0.jar shipping.jar

Validate $? "Renaming JAR file"

#/etc/systemd/system/shipping.service

systemctl daemon-reload

Validate $? "Reload daemon"

systemctl enable shipping 

Validate $? "Enabling Shipping service"

systemctl start shipping 

Validate $? "Starting Shipping service"

dnf install mysql -y

Validate $? "Installing MySQL server"

mysql -h mysql.nariops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql 

Validate $? "Loading Shipping scheema into mysql "

systemctl restart shipping

Validate $? "re-starting Shipping service"