#!/bin/bash

php_pkgs=(
  "fpm"
  "apcu"
  "devel"
  "gd"
  "gmp"
  "imap"
  "intl"
  "ldap"
  "mailparse"
  "mbstring"
  "mysqli"
  "pdo"
  "opcache"
  "pear"
  "sodium"
  "ssh2"
  "soap"
  "xdebug"
  "xml"
  "zip"
)

get_php_pkgs() {
  result="${1}"

  for php_pkg in "${php_pkgs[@]}"; do
    result+=" ${1}-${php_pkg}"
  done

  echo "${result}"
}

yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum-config-manager --disable remi-php54
yum-config-manager --disable remi-php70
yum-config-manager --disable remi-php71
yum-config-manager --disable remi-php72
yum-config-manager --disable remi-php73
yum-config-manager --disable remi-php74
yum-config-manager --disable remi-php80
yum-config-manager --disable remi-php81

yum -y install $(get_php_pkgs php74-php)
yum -y install $(get_php_pkgs php81-php)

sed -i 's/:9000/:9007/' /etc/opt/remi/php74/php-fpm.d/www.conf
sed -i 's/:9000/:9008/' /etc/opt/remi/php81/php-fpm.d/www.conf

cp -f /vagrant/config/php/99-php-fpm.conf /etc/httpd/conf.modules.d/99-php-fpm.conf
chmod 644 /etc/httpd/conf.modules.d/99-php-fpm.conf

post_install() {
  rm -f /etc/httpd/conf.d/${1}-php.conf

  ln -fs /opt/remi/${1}/root/usr/bin/pear /bin/${1}-pear
  ln -fs /opt/remi/${1}/root/usr/bin/pecl /bin/${1}-pecl
  ln -fs /opt/remi/${1}/root/usr/bin/phpize /bin/${1}-phpize
  ln -fs /opt/remi/${1}/root/usr/bin/php-config /bin/${1}-config

  cp -f /vagrant/config/php/15-xdebug.ini /etc/opt/remi/${1}/php.d/15-xdebug.ini
  chmod 644 /etc/opt/remi/${1}/php.d/15-xdebug.ini

  sed -i 's/memory_limit.*/memory_limit = -1/g' /etc/opt/remi/${1}/php.ini
  sed -i 's/max_execution_time.*/max_execution_time = 900/g' /etc/opt/remi/${1}/php.ini
  sed -i 's/max_input_time.*/max_input_time = 900/g' /etc/opt/remi/${1}/php.ini
  sed -i 's/post_max_size.*/post_max_size = 50M/g' /etc/opt/remi/${1}/php.ini
  sed -i 's/short_open_tag.*/short_open_tag = On/g' /etc/opt/remi/${1}/php.ini
  sed -i 's/upload_max_filesize.*/upload_max_filesize = 50M/g' /etc/opt/remi/${1}/php.ini
}

post_install php74
post_install php81

ln -fs $(which php81) /bin/php

systemctl enable php74-php-fpm
systemctl enable php81-php-fpm

