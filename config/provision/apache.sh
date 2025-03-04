#!/bin/bash

yum -y install httpd httpd-devel

sed -i '/IncludeOptional \/vagrant\/config\/apache.*$/d' /etc/httpd/conf/httpd.conf
echo "IncludeOptional /vagrant/config/apache/*.conf" >>/etc/httpd/conf/httpd.conf
