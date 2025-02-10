#!/bin/bash

for file in /etc/yum.repos.d/*.rpmnew; do
    if [ -f "$file" ]; then
        basefile=$(basename "$file" .rpmnew)
        mv "$file" "/etc/yum.repos.d/$basefile"
    fi
done

for file in /etc/yum.repos.d/CentOS-*.repo; do
    if [ -f "$file" ] && grep -qP '^\s*[^#\s]' "$file"; then
        sed -E -i 's|https?://mirror[^/]*\.centos\.org/|http://vault.centos.org/|g' "$file"
        sed -E -i 's/^\s*#?\s*(mirrorlist=)/#\1/g' "$file"
        sed -E -i 's/^\s*#?\s*(baseurl=)/\1/' "$file"
    fi
done

yum -y install epel-release
yum -y install https://repo.ius.io/ius-release-el7.rpm 

yum-config-manager --enable epel
yum-config-manager --enable ius
