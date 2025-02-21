#!/bin/bash

yum -y install https://repo.almalinux.org/almalinux/9/BaseOS/x86_64/os/Packages/squashfs-tools-4.4-10.git1.el9.x86_64.rpm

yum -y install snapd

systemctl enable --now snapd.service

ln -fs /var/lib/snapd/snap /snap

systemctl restart snapd snapd.socket
systemctl restart snapd snapd.service
