#!/bin/bash

brew install --force --overwrite util-linux
brew link --force --overwrite util-linux

ln -fs "$(which setsid)" /usr/local/bin/setsid
