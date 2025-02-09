#!/bin/bash

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

systemctl enable --now docker
