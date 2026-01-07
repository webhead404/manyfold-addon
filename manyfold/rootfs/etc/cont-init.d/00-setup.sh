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

# Write to s6 environment so it's available to all services
echo "$SECRET_KEY" > /var/run/s6/container_environment/SECRET_KEY_BASE

# Ensure data directory has correct permissions
mkdir -p /data
chmod 755 /data

echo "Manyfold initialization complete"
echo "Database: /data/manyfold.db"
echo "Web interface on port 3214"
