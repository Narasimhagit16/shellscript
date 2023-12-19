#!/bin/bash
file="/etc/passwd"

if [ ! -f $file ]
then
    echo "file doesnt exist"
    exit 1
fi

while IFS=":" read -r username password user_id group_id user_fullname home_dir shell_path
do
    echo " USERNAME $username"
    echo " paswword $password"
    echo " user_id $user_id"
done < $file
