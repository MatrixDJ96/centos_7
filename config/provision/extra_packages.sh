#!/bin/bash

yum -y install https://mirrors.coreix.net/li.nux.ro/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm # msttcore-fonts
yum -y install https://packages.psychotic.ninja/7/base/x86_64/RPMS/psychotic-release-1.0.0-1.el7.psychotic.noarch.rpm

yum-config-manager --enable nux-dextop
yum-config-manager --enable psychotic
yum-config-manager --enable psychotic-plus

yum -y install \
    msttcore-fonts-installer \
    urw-base35-nimbus-sans-fonts

yum -y install \
    bzip2-devel \
    libcurl-devel \
    libxslt-devel \
    libzip-devel \
    oniguruma-devel \
    readline-devel

yum -y install https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox-0.12.5-1.centos7.x86_64.rpm
