#!/bin/sh
# Force Manyfold to use /data for database persistence

# Ensure /data exists
mkdir -p /data

# Set database location in environment
export DATABASE_ADAPTER=sqlite3
export DATABASE_NAME=/data/manyfold.sqlite3

# Also set it for s6
echo "sqlite3" > /var/run/s6/container_environment/DATABASE_ADAPTER
echo "/data/manyfold.sqlite3" > /var/run/s6/container_environment/DATABASE_NAME
