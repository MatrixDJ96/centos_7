#!/bin/bash

yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm # git
yum -y install http://www.city-fan.org/ftp/contrib/yum-repo/rhel7/x86_64/city-fan.org-release-3-16.rhel7.noarch.rpm # curl

yum-config-manager -q --enable endpoint
yum-config-manager -q --enable city-fan.org

yum -y install curl git
yum -y groupinstall 'Development Tools'
yum -y install nfs-utils nfs-utils-lib portmap
yum -y install htop icu ksh libX11 libXext libXrender libjpeg libpng lynx mlocate nano openssl python3 unzip wget which xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 yum-plugin-replace yum-utils zip
