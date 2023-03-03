#!/bin/bash

yum -y replace httpd --replace-with=httpd24u
yum -y install httpd24u httpd24u-mod_ssl httpd24u-devel

sed -i '/IncludeOptional \/vagrant\/config\/apache.*$/d' /etc/httpd/conf/httpd.conf
echo "IncludeOptional /vagrant/config/apache/*.conf" >>/etc/httpd/conf/httpd.conf
