#!/bin/bash

if [[ "$1" != "--no-install" ]]; then
    yum config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

    yum -y install \
      podman \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      docker-buildx-plugin \
      docker-compose-plugin
fi

systemctl disable --now docker.socket
systemctl disable --now docker.service

mkdir -p /etc/tmpfiles.d
install -Dm644 /dev/stdin /etc/tmpfiles.d/docker.conf <<'EOF'
L+ /run/docker.sock - - - - /run/podman/podman.sock
EOF

systemctl enable --now podman.socket
systemctl --global enable podman.socket

systemd-tmpfiles --create /etc/tmpfiles.d/docker.conf
