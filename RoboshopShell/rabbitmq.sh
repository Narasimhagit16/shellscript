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

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$LOGFILE

Validate $? "setting enrlang rpm"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$LOGFILE

Validate $? "Configuring YUP repos for rabbitmq"

dnf install rabbitmq-server -y &>>$LOGFILE

Validate $? "Installing rabbitmq server"

systemctl enable rabbitmq-server &>>$LOGFILE

Validate $? "Enabling rabbitmq server"

systemctl start rabbitmq-server &>>$LOGFILE

Validate $? "Starting rabbitmq server"

rabbitmqctl add_user roboshop roboshop123 &>>$LOGFILE

Validate $? "Adding roboshop user to rabbitmq"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOGFILE

Validate $? "Giving permissions to robouser"