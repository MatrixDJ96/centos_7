#!/bin/bash

yum -y install https://dev.mysql.com/get/mysql80-community-release-el7-11.noarch.rpm

yum-config-manager --enable mysql80-community

yum -y install mysql-community-server

systemctl enable --now mysqld

PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | sed 's/.* //g')
mysql --password="${PASSWORD}" --connect-expired-password --execute "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '^Inv@l1d-P@a33w0rd_';SET GLOBAL validate_password.policy=LOW;SET GLOBAL validate_password.length=0;ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'vagrant';UPDATE mysql.user SET Host='%' WHERE User='root';"

systemctl restart mysqld
