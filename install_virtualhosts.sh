#!/bin/bash

echo Installing virtual hosts...
sudo cp -f /etc/hosts config/hosts/tmp \
  && vagrant ssh -c "sudo bash /vagrant/config/hosts/install_virtualhosts.sh" \
  && sed -i 's/\r//g' config/hosts/tmp \
  && sudo cp -f config/hosts/tmp /etc/hosts \
  && rm -f config/hosts/tmp
