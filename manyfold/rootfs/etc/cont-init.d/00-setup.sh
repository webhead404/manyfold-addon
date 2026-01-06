#!/bin/sh
# ==============================================================================
# Home Assistant Add-on: Manyfold
# Generate secret key and set up environment
# ==============================================================================

CONFIG_PATH=/data/options.json

# Generate secret key if it doesn't exist
if [ ! -f /data/secret_key ]; then
    echo "Generating SECRET_KEY_BASE..."
    tr -dc A-Za-z0-9 </dev/urandom | head -c 64 > /data/secret_key
    chmod 600 /data/secret_key
fi

# Read the secret key
SECRET_KEY=$(cat /data/secret_key)

# Read configuration with defaults
PUID=$(jq --raw-output '.puid // 1000' $CONFIG_PATH)
PGID=$(jq --raw-output '.pgid // 1000' $CONFIG_PATH)
LIBRARY_PATH=$(jq --raw-output '.library_path // "/media/3dprint-library"' $CONFIG_PATH)

echo "Configuration loaded:"
echo "  PUID: $PUID"
echo "  PGID: $PGID"
echo "  Library path: $LIBRARY_PATH"

# Write to s6 environment so it's available to all services
echo "$SECRET_KEY" > /var/run/s6/container_environment/SECRET_KEY_BASE
echo "$PUID" > /var/run/s6/container_environment/PUID
echo "$PGID" > /var/run/s6/container_environment/PGID

# Ensure data directory exists
mkdir -p /data

# Create library directory
mkdir -p "$LIBRARY_PATH"

echo "Manyfold initialization complete"
echo "Database: /data/manyfold.db"
echo "Web interface on port 3214"
