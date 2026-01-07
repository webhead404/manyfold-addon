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

# Read library path from configuration
LIBRARY_PATH=$(jq --raw-output '.library_path // "/media/3dprint-library"' $CONFIG_PATH)

# Write SECRET_KEY_BASE to s6 environment
echo "$SECRET_KEY" > /var/run/s6/container_environment/SECRET_KEY_BASE

# ALSO export it in the current environment (for Rails)
export SECRET_KEY_BASE="$SECRET_KEY"

# Write to a file that will be sourced by all processes
cat > /etc/profile.d/manyfold.sh << EOF
export SECRET_KEY_BASE="$SECRET_KEY"
export DATABASE_ADAPTER=sqlite3
export DATABASE_NAME=/data/manyfold.db
EOF
chmod +x /etc/profile.d/manyfold.sh

# Ensure data directory exists
mkdir -p /data
chmod 755 /data

# Create library directory if it doesn't exist
mkdir -p "$LIBRARY_PATH"
chmod 755 "$LIBRARY_PATH"

echo "Manyfold initialization complete"
echo "Database: /data/manyfold.db"
echo "Library path: $LIBRARY_PATH"
echo "SECRET_KEY_BASE configured: ${#SECRET_KEY} characters"
echo "Web interface on port 3214"
