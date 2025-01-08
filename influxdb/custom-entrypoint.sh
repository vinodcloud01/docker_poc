#!/bin/sh

# Step 1: Read the admin token from the Docker secret (if available)
if [ -f "/run/secrets/influxdb_admin_token" ]; then
  echo "Reading admin token from secret..."
  export DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=$(cat "$DOCKER_INFLUXDB_INIT_ADMIN_TOKEN_FILE" | tr -d '\r\n')
else
  echo "Warning: Admin token secret not found. Default token will be used."
fi

# Step 2: Check if DOCKER_INFLUXDB_INIT_MODE is already set
if [ -z "$DOCKER_INFLUXDB_INIT_MODE" ]; then
  if [ -f "/var/lib/influxdb2/influxd.bolt" ]; then
    echo "InfluxDB 2.x already initialized."
  elif [ -d "/var/lib/influxdb" ]; then
    echo "Detected InfluxDB 1.x directory. Setting DOCKER_INFLUXDB_INIT_MODE=upgrade."
    export DOCKER_INFLUXDB_INIT_MODE=upgrade
  else
    echo "No existing InfluxDB setup found. Setting DOCKER_INFLUXDB_INIT_MODE=setup."
    export DOCKER_INFLUXDB_INIT_MODE=setup
  fi
fi

# Step 3: Add any additional custom logic here
echo "Running custom entrypoint script..."
echo "Checking files in /var/lib/influxdb2:"
ls -l /var/lib/influxdb2

# Optional: Verify permissions
if [ ! -w "/var/lib/influxdb2" ]; then
  echo "Error: No write permissions for /var/lib/influxdb2"
  exit 1
fi


# Step 4: Hand off control to the original entrypoint
echo "Starting InfluxDB with original entrypoint..."
exec /entrypoint.sh "$@"
