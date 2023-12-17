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

dnf module disable mysql -y &>>$LOGFILE

Validate $? "Disable current mysql version"

#vim /etc/yum.repos.d/mysql.repo

dnf install mysql-community-server -y &>>$LOGFILE

Validate $? "Setup the MySQL5.7 repo file"

systemctl enable mysqld &>>$LOGFILE

Validate $? "Enable MySQL"

systemctl start mysqld &>>$LOGFILE

Validate $? "Enable MySQL"

mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOGFILE

Validate $? "Changing the default root password"

mysql -uroot -pRoboShop@1 &>>$LOGFILE

Validate $? "MySQL is Working"