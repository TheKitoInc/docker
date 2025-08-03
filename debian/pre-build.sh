#!/bin/bash

# Build script for Docker image
set -e

# Set package repositories
rm -f /etc/apt/sources.list.d/*
cat /dev/null > /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stable main" > /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security stable-security/updates main" >> /etc/apt/sources.list
