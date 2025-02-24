#!/bin/bash

yum config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo

yum -y install mise

echo 'eval "$(mise activate bash)"' > /etc/profile.d/mise.sh
