#!/bin/bash

pub_file="/vagrant/config/tmp_ssh_pub"
config_file="/vagrant/config/tmp_ssh_config"

if [ "$(whoami)" == "root" ]; then
  (test -f "$pub_file" && test -f "$config_file") || (echo "Required file/s not found" && exit 1)

  pip3 install -q ssh-config && ln -fs /usr/local/bin/ssh-config /usr/bin/ssh-config

  echo y | ssh-config -f "$config_file" remove vagrant.local >/dev/null
  echo y | ssh-config -f "$config_file" add vagrant.local \
    HostName="127.0.0.1" \
    User="vagrant" Port="2222" \
    IdentityFile="~/.ssh/id_vagrant" \
    IdentitiesOnly="yes" >/dev/null

  sed -i ':a;N;$!ba;s/\nHost/\n\nHost/g' "$config_file"

  mkdir -p /home/vagrant/.ssh
  chmod 700 /home/vagrant/.ssh
  touch /home/vagrant/.ssh/authorized_keys
  chmod 600 /home/vagrant/.ssh/authorized_keys
  cat "$pub_file" >>/home/vagrant/.ssh/authorized_keys

  chown -R vagrant:vagrant /home/vagrant/.ssh
else
  echo 'Please run as root'
fi
