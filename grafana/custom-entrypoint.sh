#!/bin/sh

# Step 1: Read the admin token from the Docker secret (if available)
if [ -f "/run/secrets/influxdb_admin_token" ]; then
  echo "Reading admin token from secret..."
  export INFLUXDB_ADMIN_TOKEN=$(cat "$INFLUXDB_ADMIN_TOKEN__FILE" | tr -d '\r\n')
else
  echo "Warning: Admin token secret not found. Default token will be used."
fi

# Step 2: Hand off control to the original entrypoint
echo "Starting Grafana with original entrypoint..."
exec /run.sh "$@"
