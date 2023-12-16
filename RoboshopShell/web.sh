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

dnf install nginx -y &>>$LOGFILE

Validate $? "Installing nginx"

systemctl enable nginx &>>$LOGFILE

Validate $? "Enabling  nginx"

systemctl start nginx &>>$LOGFILE

Validate $? "Starting nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE

Validate $? "Deleting existing HTML files"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>>$LOGFILE

Validate $? "Downloding web server code"

cd /usr/share/nginx/html &>>$LOGFILE

Validate $? "Change the Directory to nginx html directory"

unzip -o /tmp/web.zip &>>$LOGFILE

Validate $? "Unizipping HTML code"

#vim /etc/nginx/default.d/roboshop.conf 
cp /home/centos/shellscript/RoboshopShell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$LOGFILE

Validate $? "Copying reverse proxy sever configuration"

systemctl restart nginx &>>$LOGFILE

Validate $? "Restarting nginx server"