#!/usr/bin/with-contenv bashio
# ==============================================================================
# Start Manyfold via Docker
# ==============================================================================

bashio::log.info "Starting Manyfold container..."

# Generate secret key if not exists
if [ ! -f /data/secret_key_base ]; then
    bashio::log.info "Generating SECRET_KEY_BASE..."
    openssl rand -hex 64 > /data/secret_key_base
fi

SECRET_KEY=$(cat /data/secret_key_base)
PUID=$(bashio::config 'puid' '1000')
PGID=$(bashio::config 'pgid' '1000')

# Build docker run command
DOCKER_CMD="docker run --rm --name manyfold"
DOCKER_CMD="${DOCKER_CMD} -p 3214:3214"
DOCKER_CMD="${DOCKER_CMD} -v /data:/config"
DOCKER_CMD="${DOCKER_CMD} -v /share:/share"
DOCKER_CMD="${DOCKER_CMD} -v /media:/media"
DOCKER_CMD="${DOCKER_CMD} -e SECRET_KEY_BASE=${SECRET_KEY}"
DOCKER_CMD="${DOCKER_CMD} -e PUID=${PUID}"
DOCKER_CMD="${DOCKER_CMD} -e PGID=${PGID}"

# Optional multiuser mode
if bashio::config.true 'multiuser_enabled'; then
    DOCKER_CMD="${DOCKER_CMD} -e MULTIUSER=enabled"
    bashio::log.info "Multiuser mode enabled"
    
    if bashio::config.true 'registration_enabled'; then
        DOCKER_CMD="${DOCKER_CMD} -e REGISTRATION=enabled"
        bashio::log.info "Registration enabled"
    fi
fi

# Optional usage tracking
if bashio::config.true 'usage_tracking_enabled'; then
    DOCKER_CMD="${DOCKER_CMD} -e USAGE_TRACKING=enabled"
    bashio::log.info "Usage tracking enabled"
fi

DOCKER_CMD="${DOCKER_CMD} ghcr.io/manyfold3d/manyfold-solo:latest"

bashio::log.info "Web interface will be available at: http://homeassistant.local:3214"

# Run Manyfold
exec ${DOCKER_CMD}
