#!/bin/bash

brew install --force --overwrite mise
brew link --force --overwrite mise

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/mise activate bash)"' > /etc/profile.d/mise.sh
chmod +x /etc/profile.d/mise.sh
source /etc/profile.d/mise.sh
