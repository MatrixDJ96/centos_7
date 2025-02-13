#!/bin/bash

# Pulizia cache yum
yum clean all

# Pulizia file temporanei
find /tmp -mindepth 1 -type f -exec rm -f {} \; 2>/dev/null
find /var/tmp -mindepth 1 -type f -exec rm -f {} \; 2>/dev/null

# Pulizia file cache
find /var/cache -type f -exec rm -f {} \; 2>/dev/null

# Pulizia file loj
find /var/log -type f -name "*.log*" -exec rm -f {} \; 2>/dev/null

# Pulizia cache in ogni utente
find /root/.cache -type f -exec rm -f {} \; 2>/dev/null
find /home/*/.cache -type f -exec rm -f {} \; 2>/dev/null
