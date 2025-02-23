#!/bin/bash

cd $(dirname $0)

if [ "${1}" = "--ubuntu" ]; then
    # Add Docker's official GPG key
    apt-get update
    apt-get install -y ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update

    # Install the Docker packages
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Create CentOS 7 image
    docker build -t local/centos7 .
    docker run -t --name wsl_export local/centos7 ls / > /dev/null
    docker export wsl_export > ./CentOS.tar
    docker rm -f wsl_export > /dev/null
elif [ "${1}" = "--centos" ]; then
    # Set the hostname
    hostnamectl set-hostname vagrant.local
    echo "127.0.0.1 localhost" > /etc/hosts
    echo "127.0.1.1 $(hostname)" >> /etc/hosts
    
    # Link config files
    rm -f /vagrant/config
	mkdir -p /vagrant/projects
    chown -R vagrant:vagrant /vagrant
    ln -fs "$(pwd)/config" /vagrant/config
    
    # Run the provisioning script
    bash --login /vagrant/config/provision.sh
fi
