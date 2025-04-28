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

# Create Upgrade Script
RUN echo "#!/bin/bash" > /usr/local/bin/upgrade
RUN echo "export DEBIAN_FRONTEND=noninteractive" >> /usr/local/bin/upgrade
RUN echo "apt-get update && \\" >> /usr/local/bin/upgrade
RUN echo "apt-get upgrade -dy && \\" >> /usr/local/bin/upgrade
RUN echo "apt-get dist-upgrade -dy && \\" >> /usr/local/bin/upgrade
RUN echo "apt-get upgrade -y && \\" >> /usr/local/bin/upgrade
RUN echo "apt-get dist-upgrade -y && \\" >> /usr/local/bin/upgrade
RUN echo "apt-get autoremove -y && \\" >> /usr/local/bin/upgrade
RUN echo "apt-get autoclean -y && \\" >> /usr/local/bin/upgrade
RUN echo "exit 0" >> /usr/local/bin/upgrade
RUN chmod +x /usr/local/bin/upgrade

# Run upgrade
RUN upgrade

# Install ssl certificates
RUN apt-get install -y ca-certificates
RUN update-ca-certificates