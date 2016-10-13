#!/bin/bash
BACKUP_LOCATION="/mnt/backup"
SRC=${BACKUP_LOCATION}
cd
FILE=`ls ${SRC} | grep -v .DS`
echo $FILE

ps aux
rm -rf /var/lib/mysql/*
ls /var/lib/mysql
innobackupex --copy-back ${SRC}/${FILE}  
chown -R mysql:mysql /var/lib/mysql 
