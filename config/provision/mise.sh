#!/bin/bash

brew install --force --overwrite mise
brew link --force --overwrite mise

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/mise activate bash)"' > /etc/profile.d/mise.sh
source /etc/profile.d/mise.sh

echo '#!/bin/bash' > /bin/mise
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/mise activate bash)"' >> /bin/mise
echo 'exec /home/linuxbrew/.linuxbrew/bin/mise "$@"' >> /bin/mise
chmod +x /bin/mise
