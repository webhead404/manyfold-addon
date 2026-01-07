#!/bin/sh
# Force Manyfold to use /data for database persistence

# Ensure /data exists
mkdir -p /data

# Generate SECRET_KEY_BASE if it doesn't exist
if [ ! -f /data/secret_key_base ]; then
    echo "Generating SECRET_KEY_BASE..."
    tr -dc A-Za-z0-9 </dev/urandom | head -c 64 > /data/secret_key_base
    chmod 600 /data/secret_key_base
fi

# Read the secret key
SECRET_KEY=$(cat /data/secret_key_base)

# Set environment variables for Manyfold
export SECRET_KEY_BASE="$SECRET_KEY"
export DATABASE_ADAPTER=sqlite3
export DATABASE_NAME=/data/manyfold.sqlite3

# Also set for s6-overlay
echo "$SECRET_KEY" > /var/run/s6/container_environment/SECRET_KEY_BASE
echo "sqlite3" > /var/run/s6/container_environment/DATABASE_ADAPTER
echo "/data/manyfold.sqlite3" > /var/run/s6/container_environment/DATABASE_NAME

echo "Manyfold initialization complete"
echo "Database: /data/manyfold.sqlite3"
echo "SECRET_KEY_BASE: configured (${#SECRET_KEY} chars)"
