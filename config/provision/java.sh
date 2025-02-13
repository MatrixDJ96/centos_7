#!/bin/bash

brew install --force --overwrite openjdk@21
brew install --force --overwrite openjdk@11

brew link --force --overwrite openjdk@21

JAVA_HOME="/home/linuxbrew/.linuxbrew/opt/openjdk@21/libexec"
echo "export JAVA_HOME=\"$JAVA_HOME\"" > /etc/profile.d/java.sh
source /etc/profile.d/java.sh
