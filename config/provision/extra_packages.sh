#!/bin/bash

yum -y install https://mirrors.coreix.net/li.nux.ro/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm # msttcore-fonts

yum-config-manager --enable nux-dextop

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

yum -y install https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1.centos7.x86_64.rpm
