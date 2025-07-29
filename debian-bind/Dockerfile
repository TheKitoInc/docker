FROM debian:stable-slim

# Set environment variables
ENV ENV="/root/.bashrc"
ENV DEBIAN_FRONTEND="noninteractive"

# Clean sources.list
RUN cat /dev/null > /etc/apt/sources.list
RUN rm /etc/apt/sources.list.d/*

# Add Debian stable-updates sources
RUN echo "deb http://deb.debian.org/debian/ stable main" >> /etc/apt/sources.list.d/debian.list
RUN echo "deb-src http://deb.debian.org/debian/ stable main" >> /etc/apt/sources.list.d/debian.list

# Add Debian stable-security sources
RUN echo "deb http://security.debian.org/debian-security stable-security/updates main" >> /etc/apt/sources.list.d/security.list
RUN echo "deb-src http://security.debian.org/debian-security stable-security/updates main" >> /etc/apt/sources.list.d/security.list

# Upgrade
RUN apt-get update
RUN apt-get upgrade -yd
RUN apt-get dist-upgrade -yd
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y
RUN apt-get autoclean -y

# Install ssl certificates
RUN apt-get install -y ca-certificates
RUN update-ca-certificates

# Bind9
RUN apt-get install bind9 -y

# Ports
EXPOSE 53/udp
EXPOSE 53/tcp

# Volumes
VOLUME ["/var/run/docker.sock"]

# Docker Zone Read
RUN apt-get install -y curl
RUN apt-get install -y jq

# Copy configuration files
COPY ./named.conf /etc/bind/named.conf
COPY ./named.conf.local /etc/bind/named.conf.local
COPY ./named.conf.options /etc/bind/named.conf.options

# Copy scripts
COPY ./entrypoint.sh /entrypoint.sh
COPY ./update_zone.sh /update_zone.sh

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
  CMD dig @localhost

# Start bind9 and zone updater
RUN chmod +x /entrypoint.sh
RUN chmod +x /update_zone.sh
ENTRYPOINT ["/entrypoint.sh"]
