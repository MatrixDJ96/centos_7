#!/bin/bash

cd "${HOME}" || exit

echo "Configuring repositories..."
bash --login /vagrant/config/provision/yum.sh 2>&1 | tee -i /vagrant/config/provision/yum.log >/dev/null

echo "Installing basic packages..."
bash --login /vagrant/config/provision/basic_packages.sh 2>&1 | tee -i /vagrant/config/provision/basic_packages.log >/dev/null

echo "Installing/Configuring SELinux..."
bash --login /vagrant/config/provision/selinux.sh 2>&1 | tee -i /vagrant/config/provision/selinux.log >/dev/null

echo "Installing/Configuring SSH..."
bash --login /vagrant/config/provision/ssh.sh 2>&1 | tee -i /vagrant/config/provision/ssh.log >/dev/null

echo "Installing/Configuring Apache..."
bash --login /vagrant/config/provision/apache.sh 2>&1 | tee -i /vagrant/config/provision/apache.log >/dev/null

echo "Installing/Configuring MySQL..."
bash --login /vagrant/config/provision/mysql.sh 2>&1 | tee -i /vagrant/config/provision/mysql.log >/dev/null

echo "Installing/Configuring PHP..."
bash --login /vagrant/config/provision/php.sh 2>&1 | tee -i /vagrant/config/provision/php.log >/dev/null

echo "Installing/Configuring Composer..."
bash --login /vagrant/config/provision/composer.sh 2>&1 | tee -i /vagrant/config/provision/composer.log >/dev/null

echo "Installing/Configuring Nodejs..."
bash --login /vagrant/config/provision/nodejs.sh 2>&1 | tee -i /vagrant/config/provision/nodejs.log >/dev/null

echo "Installing extra packages..."
bash --login /vagrant/config/provision/extra_packages.sh 2>&1 | tee -i /vagrant/config/provision/extra_packages.log >/dev/null

echo "Updating system packages..."
bash --login /vagrant/config/provision/update.sh 2>&1 | tee -i /vagrant/config/provision/update.log >/dev/null

echo "Installation completed!"
