#!/bin/bash

yum -y groupinstall 'Development Tools'

yum -y install \
    curl \
    git

yum -y install \
    nfs-utils \
    libnfs-utils \
    portmap

yum -y install \
    htop \
    icu \
    ksh \
    libjpeg \
    libpng \
    libX11 \
    libXext \
    libXrender \
    lsof \
    lynx \
    mlocate \
    nano \
    openssl \
    python3 \
    unzip \
    wget \
    which \
    xorg-x11-fonts-75dpi \
    xorg-x11-fonts-Type1 \
    yum-plugin-replace \
    yum-utils \
    zip
