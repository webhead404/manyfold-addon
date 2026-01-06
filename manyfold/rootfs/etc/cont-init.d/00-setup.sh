#!/usr/bin/with-contenv bash
# ==============================================================================
# Home Assistant Community Add-ons: Manyfold
# Generate secret key and set up environment
# ==============================================================================

# Generate secret key if it doesn't exist
if [ ! -f /data/secret_key ]; then
    echo "Generating SECRET_KEY_BASE..."
    tr -dc A-Za-z0-9 </dev/urandom | head -c 64 > /data/secret_key
    chmod 600 /data/secret_key
fi

# Export the secret key
export SECRET_KEY_BASE=$(cat /data/secret_key)

# Ensure data directory has correct permissions
mkdir -p /data
chmod 755 /data

echo "Manyfold initialization complete"
echo "Database will be at: /data/manyfold.db"
echo "Web interface on port 3214"
