#!/bin/bash

# Build script for Docker image
set -e

# Set package repositories
rm -f /etc/apt/sources.list.d/*
cat /dev/null > /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stable main" > /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security stable-security/updates main" >> /etc/apt/sources.list

# Set environment variables
export DEBIAN_FRONTEND=noninteractive

# Upgrade the system
apt-get update
apt-get upgrade -yd
apt-get dist-upgrade -yd
apt-get upgrade -y
apt-get dist-upgrade -y

# Install SSL certificates
apt-get install -y --no-install-recommends ca-certificates
update-ca-certificates

# Install nginx
apt-get install -y --no-install-recommends nginx

# Install snakeoil
apt-get install -y --no-install-recommends ssl-cert

# Install curl for health checks
apt-get install -y --no-install-recommends curl

# Clean up APT when done
apt-get autoremove -y
apt-get autoclean -y
apt-get clean -y

# Remove unnecessary files
rm -rf /var/lib/apt/lists/* 
rm -rf /var/cache/apt/archives/*
rm -rf /var/cache/debconf/*-old

# Remove old dpkg info files
find /var/lib/dpkg/info -type f -name '*.old' -delete
find /var/lib/dpkg/info -type f -name '*.bak' -delete
find /var/lib/dpkg/info -type f -name '*.dpkg-*' -delete

# Map STDIO/ERRIO
ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log