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

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$LOGFILE

Validate $? "downloding remi repo"

dnf module enable redis:remi-6.2 -y &>>$LOGFILE

Validate $? "enabling Redis"

dnf install redis -y &>>$LOGFILE

Validate $? "Installing redis" 

#vim /etc/redis.conf

sed  -i 's/127.0.0.1/0.0.0.0/g' etc/redis/redis.conf &>>$LOGFILE

Validate $? "Giving remote access to Redis DB" 

systemctl enable redis &>>$LOGFILE

Validate $? "Enabling Redis"

systemctl start Redis &>>$LOGFILE

Validate $? "Start Redis"