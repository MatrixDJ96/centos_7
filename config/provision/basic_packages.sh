#!/bin/bash

yum -y groupinstall 'Development Tools'
yum -y install nfs-utils nfs-utils-lib portmap
yum -y install htop icu ksh libX11 libXext libXrender libjpeg libpng lynx mlocate nano openssl python3 unzip wget which xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 yum-plugin-replace yum-utils zip
