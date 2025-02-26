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

echo "Installing/Configuring Brew..."
bash --login /vagrant/config/provision/brew.sh 2>&1 | tee -i /vagrant/config/provision/brew.log >/dev/null

echo "Installing/Configuring Setsid..."
bash --login /vagrant/config/provision/setsid.sh 2>&1 | tee -i /vagrant/config/provision/setsid.log >/dev/null

echo "Installing/Configuring Mise..."
bash --login /vagrant/config/provision/mise.sh 2>&1 | tee -i /vagrant/config/provision/mise.log >/dev/null

echo "Installing/Configuring Nodejs..."
bash --login /vagrant/config/provision/nodejs.sh 2>&1 | tee -i /vagrant/config/provision/nodejs.log >/dev/null

echo "Installing/Configuring Java..."
bash --login /vagrant/config/provision/java.sh 2>&1 | tee -i /vagrant/config/provision/java.log >/dev/null

echo "Installing/Configuring Tomcat..."
bash --login /vagrant/config/provision/tomcat.sh 2>&1 | tee -i /vagrant/config/provision/tomcat.log >/dev/null

echo "Installing/Configuring Keycloak..."
bash --login /vagrant/config/provision/keycloak.sh 2>&1 | tee -i /vagrant/config/provision/keycloak.log >/dev/null

echo "Installing extra packages..."
bash --login /vagrant/config/provision/extra_packages.sh 2>&1 | tee -i /vagrant/config/provision/extra_packages.log >/dev/null

echo "Updating system packages..."
bash --login /vagrant/config/provision/update.sh 2>&1 | tee -i /vagrant/config/provision/update.log >/dev/null

echo "Installation completed!"
