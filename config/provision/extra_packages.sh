#!/bin/bash

yum -y install http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum -y install https://packages.psychotic.ninja/6/base/i386/RPMS/psychotic-release-1.0.0-1.el6.psychotic.noarch.rpm

yum-config-manager --enable nux-dextop
yum-config-manager --enable psychotic
yum-config-manager --enable psychotic-plus

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

nvm install 14
npm config set strict-ssl false
npm install -g yarn
npm install -g pm2

yum -y install urw-base35-nimbus-sans-fonts msttcore-fonts-installer
yum -y install bzip2-devel libcurl-devel oniguruma-devel readline-devel libxslt-devel libzip-devel
yum -y install https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox-0.12.5-1.centos7.x86_64.rpm

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"

rm -f /bin/composer
mv -f composer.phar /bin/composer

if [ "$(grep '/vagrant/projects' /home/vagrant/.bashrc)" == "" ]; then
  echo "# default working dir" >>/home/vagrant/.bashrc
  echo "[[ -e /vagrant/projects ]] && cd /vagrant/projects" >>/home/vagrant/.bashrc
fi
