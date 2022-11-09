#!/bin/bash

yum -y replace httpd --replace-with=httpd24u
yum -y install httpd24u httpd24u-mod_ssl httpd24u-devel

systemctl enable httpd
