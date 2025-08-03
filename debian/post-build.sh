#!/bin/bash

# Build script for Docker image
set -e

# make upgrade script executable
chmod +x /bin/upgrade.sh
ln -s /bin/upgrade.sh /bin/upgrade

# upgrade the system packages
/bin/upgrade

# make init script executable
chmod +x /init.sh

