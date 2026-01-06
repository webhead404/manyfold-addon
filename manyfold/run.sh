#!/bin/sh
set -e

# Generate a secret key if not exists
if [ ! -f /data/secret_key ]; then
    echo "Generating secret key..."
    tr -dc A-Za-z0-9 </dev/urandom | head -c 64 > /data/secret_key
fi

# Set environment variables
export SECRET_KEY_BASE=$(cat /data/secret_key)
export DATABASE_ADAPTER=sqlite3
export DATABASE_NAME=/data/manyfold.db

# Ensure database directory exists and has correct permissions
mkdir -p /data
chmod 755 /data

echo "Starting Manyfold..."
echo "Web interface will be available on port 3214"

# Execute the original Manyfold entrypoint
exec /init
