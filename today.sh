#!/bin/bash
#This script will print usernames of all users on a Linux system together with their home directories.
#Command to get user with homedir with delimeter.

USRHOMEDIR=$(getent passwd |awk 'BEGIN{FS=":"; OFS=":"} { print $1, $6 }')

#This line will get the md5sum of the above output.

getent passwd |awk 'BEGIN{FS=":"; OFS=":"} { print $1, $6 }' | md5sum > /var/log/current_users

md5sum=$(getent passwd |awk 'BEGIN{FS=":"; OFS=":"} { print $1, $6 }' | md5sum)
FILE=/var/log/current_users
value=$(cat /var/log/current_users)

if [ -f "$FILE" ] && { "$value" != "$md5sum" ; echo "$(date +%Y-%m-%d_%H%M) : the md5sum has been changed from old value $value to new value $md5sum" >> /var/log/user_changes}
 then 
    echo "These are the usernames of all users on this Linux system with their home directories.
$USRHOMEDIR"
fi
#second commit testing
