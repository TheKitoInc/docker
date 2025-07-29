#!/bin/bash

# Fail on any error
set -e

# Set executable permissions for the update script
chmod +x /update_zone.sh

# Start zone updater in background
/update_zone.sh &

# Start named in foreground
exec named -g -c /etc/bind/named.conf