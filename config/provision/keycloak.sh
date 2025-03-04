#!/bin/bash

keycloak_major_version="26"
keycloak_minor_version="1"
keycloak_patch_version="5"
keycloak_full_version="${keycloak_major_version}.${keycloak_minor_version}.${keycloak_patch_version}"

JAVA_HOME=/usr/lib/jvm/jre-21

userdel -f keycloak
useradd -M -U -d /opt/keycloak -s /usr/bin/nologin keycloak
passwd -l keycloak > /dev/null

rm -f keycloak-${keycloak_full_version}.tar.gz
rm -rf keycloak-${keycloak_full_version}

wget https://github.com/keycloak/keycloak/releases/download/${keycloak_full_version}/keycloak-${keycloak_full_version}.tar.gz
# wget https://github.com/keycloak/keycloak/archive/${keycloak_full_version}/keycloak-${keycloak_full_version}.tar.gz

mkdir -p /usr/lib/systemd/system
mkdir -p /usr/lib/sysusers.d
mkdir -p /usr/lib/tmpfiles.d
mkdir -p /opt/keycloak/latest

rm -rf /opt/keycloak/backup

if [ -d /opt/keycloak/latest ]; then
  mv /opt/keycloak/latest /opt/keycloak/backup
fi

tar -xf keycloak-${keycloak_full_version}.tar.gz
mv keycloak-${keycloak_full_version} /opt/keycloak/latest

cp -f -u /opt/keycloak/backup/providers/* /opt/keycloak/latest/providers

cp -f /vagrant/config/keycloak/keycloak.service /usr/lib/systemd/system/keycloak.service
cp -f /vagrant/config/keycloak/keycloak.sysusers /usr/lib/sysusers.d/keycloak.conf
cp -f /vagrant/config/keycloak/keycloak.tmpfiles /usr/lib/tmpfiles.d/keycloak.conf
cp -f /vagrant/config/keycloak/keycloak.conf /opt/keycloak/latest/conf/keycloak.conf

sed -i -E "s|(JAVA_HOME=).*|\"\1${JAVA_HOME}\"|" /usr/lib/systemd/system/keycloak.service

chmod 644 /usr/lib/systemd/system/keycloak.service
chmod 644 /usr/lib/sysusers.d/keycloak.conf
chmod 644 /usr/lib/tmpfiles.d/keycloak.conf
chmod 644 /opt/keycloak/latest/conf/keycloak.conf

rm -f keycloak-${keycloak_full_version}.tar.gz

chown -R keycloak:keycloak /opt/keycloak
chmod +x /opt/keycloak/latest/bin/*.sh

mysql --password=vagrant --execute "CREATE DATABASE IF NOT EXISTS keycloak;"

systemctl daemon-reload

systemctl enable --now keycloak
