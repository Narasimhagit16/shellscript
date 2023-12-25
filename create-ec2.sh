AMI=ami-03265a0778a880afb
SG=sg-0173e5458efd4d9c1
HOSTED_ZONE=temp
DNS=temp


aws ec2 run-instances --image-id $AMI --count 1 --instance-type t2.micro  --security-group-ids $SG --tags [{Key=Name,Value=node1}]

