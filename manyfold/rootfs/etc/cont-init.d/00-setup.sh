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

# Read configuration
PUID=$(jq --raw-output '.puid // empty' $CONFIG_PATH)
PGID=$(jq --raw-output '.pgid // empty' $CONFIG_PATH)
LIBRARY_PATH=$(jq --raw-output '.library_path // "/media/3dprint-library"' $CONFIG_PATH)

# Write SECRET_KEY_BASE to s6 environment
echo "$SECRET_KEY" > /var/run/s6/container_environment/SECRET_KEY_BASE

# Only set PUID/PGID if they are configured and not empty
if [ -n "$PUID" ] && [ "$PUID" != "null" ]; then
    echo "$PUID" > /var/run/s6/container_environment/PUID
    echo "PUID set to: $PUID"
else
    # Remove PUID from environment if not set
    rm -f /var/run/s6/container_environment/PUID
    echo "PUID not configured - Manyfold will use default"
fi

if [ -n "$PGID" ] && [ "$PGID" != "null" ]; then
    echo "$PGID" > /var/run/s6/container_environment/PGID
    echo "PGID set to: $PGID"
else
    # Remove PGID from environment if not set
    rm -f /var/run/s6/container_environment/PGID
    echo "PGID not configured - Manyfold will use default"
fi

# Ensure data directory has correct permissions
mkdir -p /data
chmod 755 /data

# Create library directory if configured and it doesn't exist
if [ -n "$LIBRARY_PATH" ] && [ "$LIBRARY_PATH" != "null" ]; then
    mkdir -p "$LIBRARY_PATH"
    chmod 755 "$LIBRARY_PATH"
    echo "Library path: $LIBRARY_PATH"
    
    # Set ownership if PUID/PGID are set
    if [ -n "$PUID" ] && [ -n "$PGID" ] && [ "$PUID" != "null" ] && [ "$PGID" != "null" ]; then
        chown -R $PUID:$PGID "$LIBRARY_PATH" 2>/dev/null || true
        chown -R $PUID:$PGID /data 2>/dev/null || true
    fi
fi

echo "Manyfold initialization complete"
echo "Database: /data/manyfold.db"
echo "Web interface on port 3214"
