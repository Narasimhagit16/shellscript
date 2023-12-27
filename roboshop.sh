#!/bin/bash
AMI=ami-03265a0778a880afb
SG=sg-0173e5458efd4d9c1
HOSTED_ZONE=Z0601407A5EHLIBKCO7P
DNS=nariops.online

Servers=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")

for I in {$Servers[@]}
do
    echo "------$I"
    if [ $I == "mongodb" ] || [ $I == "mysql" ] || [ $I == "shipping" ]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi
    #IP_ADDRESS=$(aws ec2 run-instances --image-id ami-03265a0778a880afb --instance-type $INSTANCE_TYPE --security-group-ids sg-087e7afb3a936fce7 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$I}]" --query 'Instances[0].PrivateIpAddress' --output text)
    
    IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --count 1 --instance-type t2.micro  --security-group-ids sg-0173e5458efd4d9c1 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$I}]" --query 'Instances[0].PrivateIpAddress' --output text)

    echo "$I: $IP_ADDRESS"

    #create R53 record, make sure you delete existing record
    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Creating a record set for cognito endpoint"
        ,"Changes": [
            {
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$I'.'$DOMAIN_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP_ADDRESS'"
            }]
        }
        }]
    }
        '

done