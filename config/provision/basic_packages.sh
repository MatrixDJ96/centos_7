#!/bin/bash

yum -y install https://repo.ius.io/ius-release-el7.rpm

yum -y groupinstall 'Development Tools'
yum -y install nfs-utils nfs-utils-lib portmap
yum -y install epel-release git htop icu ksh libpng libjpeg libX11 libXext libXrender lynx mlocate nano openssl python3 yum-utils yum-plugin-replace wget xorg-x11-fonts-Type1 xorg-x11-fonts-75dpi unzip zip
