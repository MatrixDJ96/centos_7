#!/bin/bash

openjdk_pkg="openjdk@17"

brew install --force --overwrite $openjdk_pkg
brew link --force --overwrite $openjdk_pkg

JAVA_HOME="/home/linuxbrew/.linuxbrew/opt/$openjdk_pkg/libexec"
echo "export JAVA_HOME=\"$JAVA_HOME\"" > /etc/profile.d/java.sh
source /etc/profile.d/java.sh
