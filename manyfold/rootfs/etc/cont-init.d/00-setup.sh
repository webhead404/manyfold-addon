#!/bin/sh
# ==============================================================================
# Home Assistant Add-on: Manyfold
# Generate secret key and set up environment
# ==============================================================================

CONFIG_PATH=/data/options.json

echo "=== Manyfold Add-on Initialization ==="
echo "Reading config from: $CONFIG_PATH"

# Show what's in the config file
if [ -f "$CONFIG_PATH" ]; then
    echo "Config file contents:"
    cat "$CONFIG_PATH"
else
    echo "WARNING: Config file not found!"
fi

# Generate secret key if it doesn't exist
if [ ! -f /data/secret_key ]; then
    echo "Generating SECRET_KEY_BASE..."
    tr -dc A-Za-z0-9 </dev/urandom | head -c 64 > /data/secret_key
    chmod 600 /data/secret_key
fi

# Read the secret key
SECRET_KEY=$(cat /data/secret_key)
echo "Secret key length: ${#SECRET_KEY}"

# Read configuration with defaults
PUID=$(jq --raw-output '.puid // 1000' $CONFIG_PATH 2>/dev/null || echo "1000")
PGID=$(jq --raw-output '.pgid // 1000' $CONFIG_PATH 2>/dev/null || echo "1000")
LIBRARY_PATH=$(jq --raw-output '.library_path // "/media/3dprint-library"' $CONFIG_PATH 2>/dev/null || echo "/media/3dprint-library")

echo "Configuration loaded:"
echo "  PUID: '$PUID' (length: ${#PUID})"
echo "  PGID: '$PGID' (length: ${#PGID})"
echo "  Library path: '$LIBRARY_PATH'"

# Ensure we have valid values
if [ -z "$PUID" ] || [ "$PUID" = "null" ]; then
    echo "WARNING: PUID is empty or null, using 1000"
    PUID="1000"
fi

if [ -z "$PGID" ] || [ "$PGID" = "null" ]; then
    echo "WARNING: PGID is empty or null, using 1000"
    PGID="1000"
fi

# Write to s6 environment so it's available to all services
echo "$SECRET_KEY" > /var/run/s6/container_environment/SECRET_KEY_BASE
echo "$PUID" > /var/run/s6/container_environment/PUID
echo "$PGID" > /var/run/s6/container_environment/PGID

echo "Wrote to s6 environment:"
echo "  PUID file: $(cat /var/run/s6/container_environment/PUID 2>/dev/null || echo 'ERROR')"
echo "  PGID file: $(cat /var/run/s6/container_environment/PGID 2>/dev/null || echo 'ERROR')"

# Ensure data directory exists
mkdir -p /data

# Create library directory
mkdir -p "$LIBRARY_PATH"

echo "=== Manyfold initialization complete ==="
echo "Database: /data/manyfold.db"
echo "Web interface on port 3214"
