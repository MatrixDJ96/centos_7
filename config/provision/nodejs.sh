#!/bin/bash

cd "${HOME}" || exit

if [ "$(id -u)" -eq 0 ]; then
	rm -rf ~/.local/share/mise/shims

    mise install node@20
    mise install node@18
    mise install node@16
    mise install node@14

    mise x node@20 -- npm install yarn -g
    mise x node@18 -- npm install yarn -g
    mise x node@16 -- npm install yarn -g
    mise x node@14 -- npm install yarn -g

    mise x node@20 -- npm install pm2 -g

	mise reshim
fi

if [[ "$(hostnamectl --static)" == "vagrant.local" ]]; then
    if [ "$(id -u)" -eq 0 ]; then
        sudo -u vagrant bash --login "${0}"
    else
		rm -rf ~/.local/share/mise/shims

        mkdir -p ~/.local/share/mise/shims
        mkdir -p ~/.local/share/mise/installs/node
        mkdir -p ~/.local/share/mise/downloads/node

        node_vagrant=~/.local/share/mise/installs/node
        node_root=/root/.local/share/mise/installs/node

        for version in $(sudo ls "${node_root}"); do
            if [ -d "${node_root}/${version}" ]; then
                rm -rf "${node_vagrant}/${version}"
            fi

            sudo cp -R "${node_root}/${version}" "${node_vagrant}/${version}"
            sudo chown -R vagrant:vagrant "${node_vagrant}/${version}"
        done

        mise reshim
    fi
fi
