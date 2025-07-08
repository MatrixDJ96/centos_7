#!/bin/bash

yum -y install openssh-server openssh-clients

sed -i -E 's/^\s*#?\s*PasswordAuthentication\s*\S+\s*$/PasswordAuthentication yes/' /etc/ssh/sshd_config

systemctl enable --now sshd
