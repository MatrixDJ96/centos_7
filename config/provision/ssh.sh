#!/bin/bash

yum -y install openssh-server openssh-clients

if [[ "$(hostnamectl --static)" == "vagrant.local" ]]; then
    sed -i -E 's/^\s*#?\s*Port\s*[0-9]+\s*$/Port 2222/' /etc/ssh/sshd_config
fi

sed -i -E 's/^\s*#?\s*PasswordAuthentication\s*\S+\s*$/PasswordAuthentication yes/' /etc/ssh/sshd_config

systemctl enable --now sshd
