#!/bin/bash
DBUSER=$1
DBPASS=$2

if [ "${DBUSER}" == "" ] || [ "${DBPASS}" == "" ]; then
  echo "Please provide username and password (backup.sh root password)"
  exit
fi

echo $DBUSER
echo $DBPASS
BACKUP_LOCATION="/mnt/backup"
rm -rf ${BACKUP_LOCATION}/*
innobackupex --defaults-file=/etc/mysql/my.cnf --host=mariadb --user=${DBUSER} --password=${DBPASS} ${BACKUP_LOCATION}
FILE=`ls ${BACKUP_LOCATION} | grep -v .DS`
innobackupex --defaults-file=/etc/mysql/my.cnf --host=mariadb --user=${DBUSER} --password=${DBPASS} --apply-log ${BACKUP_LOCATION}/${FILE} || exit 1
