#!/bin/bash

cd $(dirname $0)

echo Installing vagrant machine...
vagrant up --provision --provider=${1}

./install_virtualhosts.sh
./install_ssh_key.sh

vagrant reload

echo Done
