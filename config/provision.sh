#!/bin/bash

cd ${HOME}

echo "Disabling SELinux..."
exec /vagrant/config/provision/selinux.sh 2>&1 | tee -i /vagrant/config/provision/selinux.log >/dev/null

echo "Configuring SSH..."
exec /vagrant/config/provision/ssh.sh 2>&1 | tee -i /vagrant/config/provision/ssh.log >/dev/null

echo "Cleaning system..."
exec /vagrant/config/provision/clean.sh 2>&1 | tee -i /vagrant/config/provision/clean.log >/dev/null

echo "Installing basic packages..."
exec /vagrant/config/provision/basic_packages.sh 2>&1 | tee -i /vagrant/config/provision/basic_packages.log >/dev/null

echo "Installing/Configuring MySQL 8..."
exec /vagrant/config/provision/mysql.sh 2>&1 | tee -i /vagrant/config/provision/mysql.log >/dev/null

echo "Installing/Configuring PHP 7.4/8.1..."
exec /vagrant/config/provision/php.sh 2>&1 | tee -i /vagrant/config/provision/php.log >/dev/null

echo "Installing/Configuring Apache 2..."
exec /vagrant/config/provision/apache.sh 2>&1 | tee -i /vagrant/config/provision/apache.log >/dev/null

echo "Installing extra packages..."
exec /vagrant/config/provision/extra_packages.sh 2>&1 | tee -i /vagrant/config/provision/extra_packages.log >/dev/null

echo "Updating system..."
exec /vagrant/config/provision/update.sh 2>&1 | tee -i /vagrant/config/provision/update.log >/dev/null

echo "Installation completed!"
