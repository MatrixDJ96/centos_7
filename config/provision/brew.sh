#!/bin/bash

yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm # git
yum -y install http://www.city-fan.org/ftp/contrib/yum-repo/rhel7/x86_64/city-fan.org-release-3-16.rhel7.noarch.rpm # curl

yum-config-manager --enable endpoint
yum-config-manager --enable city-fan.org

yum -y install curl git

touch /.dockerenv

NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' > /etc/profile.d/brew.sh
source /etc/profile.d/brew.sh

echo '#!/bin/bash' > /bin/brew
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /bin/brew
echo 'exec /home/linuxbrew/.linuxbrew/bin/brew "$@"' >> /bin/brew
chmod +x /bin/brew
