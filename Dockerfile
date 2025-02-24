FROM redhat/ubi9-init:latest

ENV container=docker
ENV username=vagrant

# Updating the system
RUN set -eux; \
    yum update -y

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
    mkdir -p /etc/sysctl.d; \
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
