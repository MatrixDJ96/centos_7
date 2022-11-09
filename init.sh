#!/bin/bash

echo Installing vagrant machine...
vagrant up --provision --provider=${1}

if [[ "${1,,}" == "virtualbox" ]]; then
	echo Installing Virtualbox Guest Additions...
	vagrant vbguest --auto-reboot --no-provision
fi

vagrant reload

echo Now you should install virtual hosts running 'install_virtualhosts.sh'
