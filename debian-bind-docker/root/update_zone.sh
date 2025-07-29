#!/bin/bash

# Zones 
ZONE_FILE="/etc/bind/db.docker.local"

# Detect the container’s own IPv4 and IPv6 addresses
SELF_IP=$(ip -4 addr show eth0 | awk '/inet / {print $2}' | cut -d/ -f1)
SELF_IP6=$(ip -6 addr show eth0 | awk '/inet6 / && !/fe80/ {print $2}' | cut -d/ -f1 | head -n 1)

echo "Self IPv4: $SELF_IP"
echo "Self IPv6: $SELF_IP6"

getZoneHeader() {
  echo "\$TTL 3600"
  echo "@ IN SOA ns.docker.local. admin.docker.local. ("
  echo "  $(date +%m%d%H%M%S) ; Serial"
  echo "  3600       ; Refresh"
  echo "  1800       ; Retry"
  echo "  604800     ; Expire"
  echo "  86400      ; Minimum TTL"
  echo ")"  
  echo "@ IN NS ns.docker.local."
  [ -n "$SELF_IP" ] && echo "ns IN A $SELF_IP"
  [ -n "$SELF_IP6" ] && echo "ns IN AAAA $SELF_IP6"
}
 

getContainerRecords() {
  containers=$(curl --silent --unix-socket /var/run/docker.sock http://localhost/containers/json)

  if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to connect to Docker socket"
    return 1
  fi

  echo "$containers" | jq -r '
    .[] |
    {name: .Names[0][1:], networks: .NetworkSettings.Networks} |
    .name as $name |
    .networks | to_entries[] |
    .value as $net |
    [
      (select($net.IPAddress and $net.IPAddress != "") | "\($name) IN A \($net.IPAddress)"),
      (select($net.GlobalIPv6Address and $net.GlobalIPv6Address != "") | "\($name) IN AAAA \($net.GlobalIPv6Address)")
    ] | .[]
  ' | tr '_' '-'
}

LAST_RECORDS=""

# Main loop to generate the zone file
while true; do
  sleep 10
  
  RECORDS=$(getContainerRecords)

  if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to retrieve container records"    
    continue
  fi

  if [ "$RECORDS" == "$LAST_RECORDS" ]; then
    echo "No changes detected, skipping update."    
    continue
  fi

  echo "Generating zone file at $(date)..."

  cat /dev/null > "$ZONE_FILE"
  getZoneHeader >> "$ZONE_FILE"
  echo "$RECORDS" >> "$ZONE_FILE"

  kill -HUP $(pidof named) || {
    echo "[ERROR] Failed to reload named service"
    continue
  }
  
  LAST_RECORDS="$RECORDS"

  echo "Zone file updated successfully."  
done