#!/bin/bash

cd "${HOME}" || exit

if [ "$(id -u)" -eq 0 ]; then
    brew install --force --overwrite node@20
    brew install --force --overwrite node@18

    mise sync node --brew
    mise install node@16
    mise install node@14

    mise x node@20 -- npm install yarn -g
    mise x node@18 -- npm install yarn -g
    mise x node@16 -- npm install yarn -g
    mise x node@14 -- npm install yarn -g
fi

if [[ "$(hostnamectl --static)" == "vagrant.local" ]]; then
    if [ "$(id -u)" -eq 0 ]; then
        sudo -u vagrant bash --login "${0}"
    else
        mkdir -p ~/.local/share/mise/downloads/node
        mkdir -p ~/.local/share/mise/installs/node
        mkdir -p ~/.local/share/mise/shims

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
