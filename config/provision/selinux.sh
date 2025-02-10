#!/bin/bash

yum -y install selinux-policy selinux-policy-targeted policycoreutils policycoreutils-python

sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
setenforce 0
