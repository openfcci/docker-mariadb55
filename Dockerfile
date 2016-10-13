FROM mariadb:5.5
MAINTAINER Dustin Rue <dustin.rue@forumcomm.com>

RUN apt-get update && apt-get install procps -y
ADD backup.sh /usr/local/sbin/backup.sh
ADD restore.sh /usr/local/sbin/restore.sh
RUN chmod +x /usr/local/sbin/*.sh
RUN mkdir /mnt/backup
