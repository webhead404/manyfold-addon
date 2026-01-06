#!/bin/sh
# ==============================================================================
# Home Assistant Add-on: Manyfold
# Generate secret key and set up environment
# ==============================================================================

CONFIG_PATH=/data/options.json

echo "=== Manyfold Add-on Initialization ==="

# Generate secret key if it doesn't exist
if [ ! -f /data/secret_key ]; then
    echo "Generating SECRET_KEY_BASE..."
    tr -dc A-Za-z0-9 </dev/urandom | head -c 64 > /data/secret_key
    chmod 600 /data/secret_key
fi

# Read the secret key
SECRET_KEY=$(cat /data/secret_key)

# Read library path from configuration
LIBRARY_PATH=$(jq --raw-output '.library_path // "/media/3dprint-library"' $CONFIG_PATH 2>/dev/null || echo "/media/3dprint-library")

echo "Configuration:"
echo "  Library path: $LIBRARY_PATH"

# Write SECRET_KEY_BASE to s6 environment (this is what Manyfold needs)
echo "$SECRET_KEY" > /var/run/s6/container_environment/SECRET_KEY_BASE

# DO NOT set PUID/PGID - Manyfold's Rakefile expects usernames, not UIDs
# Manyfold will run as the container's default user

# Ensure data directory exists
mkdir -p /data

# Create library directory
mkdir -p "$LIBRARY_PATH"

echo "=== Manyfold initialization complete ==="
echo "Database: /data/manyfold.db"
echo "Library: $LIBRARY_PATH"
echo "Web interface on port 3214"
