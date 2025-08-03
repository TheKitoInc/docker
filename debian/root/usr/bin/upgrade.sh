#!/usr/bin/env bash

# Exit on any error
set -e

# Set environment variables
export DEBIAN_FRONTEND=noninteractive

# Update package repositories
apt-get update

# Upgrade the system packages
apt-get upgrade -yd
apt-get dist-upgrade -yd
apt-get upgrade -y
apt-get dist-upgrade -y

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