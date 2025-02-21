FROM centos:7

ENV container=docker
ENV username=vagrant

# Fixing the repositories
RUN set -eux; \
    cd /etc/yum.repos.d; \
    for file in *.repo; do \
      if [ -f "$file" ] && grep -qP '^\s*[^#\s]' "$file"; then \
        sed -E -i 's|https?://mirror[^/]*\.centos\.org/|http://vault.centos.org/|g' "$file"; \
        sed -E -i 's/^\s*#?\s*(mirrorlist=)/#\1/g' "$file"; \
        sed -E -i 's/^\s*#?\s*(baseurl=)/\1/' "$file"; \
      fi; \
    done

# Updating the system
RUN set -eux; \
    yum update -y

# Enabling systemd support
RUN set -eux; \
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
    yum -y reinstall systemd

# Creating default user
RUN set -eux; \
    useradd "$username"; \
    echo "$username" | passwd --stdin "$username"

# Configuring sudo
RUN set -eux; \
    yum install -y sudo; \
    sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers; \
    echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant; \
    chmod 0440 /etc/sudoers.d/vagrant

# Disabling IPv6
RUN set -eux; \
    echo "net.ipv6.conf.all.disable_ipv6=1" > /etc/sysctl.d/disable-ipv6.conf; \
    echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.d/disable-ipv6.conf

# Configuring wsl.conf
RUN set -eux; \
    echo -e "[boot]" > /etc/wsl.conf; \
    echo -e "systemd=true\n" >> /etc/wsl.conf; \
    echo -e "[network]" >> /etc/wsl.conf; \
    echo -e "generateHosts=false" >> /etc/wsl.conf; \
    echo -e "hostname=vagrant.local\n" >> /etc/wsl.conf; \
    echo -e "[user]" >> /etc/wsl.conf; \
    echo -e "default=$username\n" >> /etc/wsl.conf

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
