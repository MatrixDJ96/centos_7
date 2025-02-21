#!/bin/bash

yum -y install \
   autoconf \
   automake \
   binutils \
   gcc \
   gcc-c++ \
   gdb \
   glibc-devel \
   libtool \
   make \
   pkgconf \
   pkgconf-m4 \
   pkgconf-pkg-config \
   redhat-rpm-config \
   rpm-build \
   strace

yum -y install \
   git \
   perl-Fedora-VSP \
   perl-generators \
   source-highlight \
   valgrind \
   valgrind-devel

yum -y install \
    hostname \
    lsof \
    nano \
    openssl \
    unzip \
    wget \
    which \
    zip

if [[ "$(hostnamectl --static)" != "vagrant.local" ]]; then  
   yum -y install \
      htop \
      mlocate
fi
