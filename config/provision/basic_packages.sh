#!/bin/bash

yum -y install https://repo.ius.io/ius-release-el7.rpm

yum -y groupinstall 'Development Tools'
yum -y install epel-release git icu ksh libpng libjpeg libX11 libXext libXrender mlocate nano openssl yum-utils yum-plugin-replace wget xorg-x11-fonts-Type1 xorg-x11-fonts-75dpi unzip zip
