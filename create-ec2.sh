AMI=ami-03265a0778a880afb
SG=sg-0173e5458efd4d9c1
HOSTED_ZONE=temp
DNS=temp


aws ec2 run-instances --image-id $AMI --count 1 --instance-type t2.micro  --security-group-ids sg-0173e5458efd4d9c1 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=node1}]"

#IP_ADDRESS=$(aws ec2 run-instances --image-id ami-03265a0778a880afb --instance-type $INSTANCE_TYPE --security-group-ids sg-087e7afb3a936fce7 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)