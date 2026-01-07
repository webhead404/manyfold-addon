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
echo "  Database: /data/manyfold.db"

# Write environment variables to s6
echo "$SECRET_KEY" > /var/run/s6/container_environment/SECRET_KEY_BASE

# CRITICAL: Force Manyfold to use /data for database, not /config
echo "sqlite3" > /var/run/s6/container_environment/DATABASE_ADAPTER
echo "/data/manyfold.db" > /var/run/s6/container_environment/DATABASE_NAME
echo "/data" > /var/run/s6/container_environment/DATABASE_PATH

# Also set it in the shell environment for any scripts
export DATABASE_ADAPTER=sqlite3
export DATABASE_NAME=/data/manyfold.db
export DATABASE_PATH=/data

# Ensure data directory exists with correct permissions
mkdir -p /data
chmod 777 /data  # Make it fully accessible

# Create library directory with full permissions
mkdir -p "$LIBRARY_PATH"
chmod -R 777 "$LIBRARY_PATH"  # Make library fully accessible for read/write/scan

# Ensure Manyfold can access the directory
chown -R root:root "$LIBRARY_PATH" 2>/dev/null || true
chown -R root:root /data 2>/dev/null || true

echo "Setting permissions on library directory..."
echo "  Path: $LIBRARY_PATH"
echo "  Permissions: 777 (full access)"

# Remove any old database from wrong location
if [ -f /config/manyfold.sqlite3 ]; then
    echo "⚠ WARNING: Found old database at /config/manyfold.sqlite3"
    echo "  This will be ignored. Database is now at /data/manyfold.db"
fi

echo "=== Manyfold initialization complete ==="
echo "Secret key configured"
echo "Database location: /data/manyfold.db" 
echo "Library: $LIBRARY_PATH (permissions: 777)"
echo "Web interface on port 3214"
