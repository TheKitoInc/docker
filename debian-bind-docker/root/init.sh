#!/bin/bash

# Fail on any error
set -e

# Start zone updater in background
chmod +x /update_zone.sh
/update_zone.sh &

# Start named in foreground
exec named -g -c /etc/bind/named.conf