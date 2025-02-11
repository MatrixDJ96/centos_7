#!/bin/bash

yum -y install snapd

systemctl enable --now snapd.service

ln -fs /var/lib/snapd/snap /snap

systemctl restart snapd snapd.socket
systemctl restart snapd snapd.service
