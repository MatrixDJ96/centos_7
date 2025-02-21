#!/bin/bash

yum -y install libselinux-utils

sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
setenforce 0
