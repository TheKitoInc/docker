#!/bin/bash

# Fail on any error
set -e

# Start nginx in foreground
exec nginx -g 'daemon off;'