#!/bin/sh
# ==============================================================================
# Home Assistant Add-on: Homebox
# Configure environment variables from add-on options
# ==============================================================================

CONFIG_PATH=/data/options.json

# Ensure /data exists
mkdir -p /data

# Read configuration options
LOG_LEVEL=$(jq --raw-output '.log_level // "info"' $CONFIG_PATH)
MAX_UPLOAD=$(jq --raw-output '.max_upload_size // "10"' $CONFIG_PATH)
ALLOW_REG=$(jq --raw-output '.allow_registration // "true"' $CONFIG_PATH)

# Set Homebox environment variables
export HBOX_LOG_LEVEL="$LOG_LEVEL"
export HBOX_LOG_FORMAT="text"
export HBOX_WEB_MAX_UPLOAD_SIZE="$MAX_UPLOAD"
export HBOX_OPTIONS_ALLOW_REGISTRATION="$ALLOW_REG"
export HBOX_STORAGE_DATA="/data"
export HBOX_STORAGE_SQLITE_URL="/data/homebox.db?_fk=1"
export HBOX_MODE="production"

# Write to s6-overlay environment
echo "$LOG_LEVEL" > /var/run/s6/container_environment/HBOX_LOG_LEVEL
echo "text" > /var/run/s6/container_environment/HBOX_LOG_FORMAT
echo "$MAX_UPLOAD" > /var/run/s6/container_environment/HBOX_WEB_MAX_UPLOAD_SIZE
echo "$ALLOW_REG" > /var/run/s6/container_environment/HBOX_OPTIONS_ALLOW_REGISTRATION
echo "/data" > /var/run/s6/container_environment/HBOX_STORAGE_DATA
echo "/data/homebox.db?_fk=1" > /var/run/s6/container_environment/HBOX_STORAGE_SQLITE_URL
echo "production" > /var/run/s6/container_environment/HBOX_MODE

echo "Homebox initialization complete"
echo "Log level: $LOG_LEVEL"
echo "Max upload size: ${MAX_UPLOAD}MB"
echo "Registration enabled: $ALLOW_REG"
echo "Database: /data/homebox.db"
echo "Web interface on port 7745"
