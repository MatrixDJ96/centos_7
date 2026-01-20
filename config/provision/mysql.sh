#!/bin/bash

yum -y install https://dev.mysql.com/get/mysql84-community-release-el9-2.noarch.rpm

yum config-manager --disable mysql80-community
yum config-manager --enable mysql-8.4-lts-community

yum -y install mysql-community-server

mkdir -p /etc/sysconfig

install -m 0755 -o root -g root \
  /vagrant/config/mysql/entrypoint.sh \
  /usr/bin/mysqld_pre_systemd

install -m 0644 -o root -g root \
  /vagrant/config/mysql/environment \
  /etc/sysconfig/mysql

systemctl enable mysqld
