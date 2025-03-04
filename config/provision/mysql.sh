#!/bin/bash

yum -y install https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm

yum config-manager --disable mysql80-community
yum config-manager --enable mysql-8.4-lts-community

yum -y install mysql-community-server

systemctl enable --now mysqld

PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | sed 's/.* //g')
mysql --password="${PASSWORD}" --connect-expired-password --execute "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '^Inv@l1d-P@a33w0rd_';SET GLOBAL validate_password.policy=LOW;SET GLOBAL validate_password.length=0;ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'vagrant';UPDATE mysql.user SET Host='%' WHERE User='root';"

systemctl restart mysqld
