ARG BUILD_FROM=ghcr.io/manyfold3d/manyfold-solo:latest
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Labels
LABEL \
    io.hass.name="Manyfold" \
    io.hass.description="Self-hosted digital asset manager for 3D print files" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="Home Assistant Community" \
    org.opencontainers.image.title="Manyfold" \
    org.opencontainers.image.description="Self-hosted digital asset manager for 3D print files" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Home Assistant Community" \
    org.opencontainers.image.url="https://github.com/manyfold3d/manyfold" \
    org.opencontainers.image.source="https://github.com/manyfold3d/manyfold"

# Copy root filesystem
COPY rootfs /

# Install bashio for Home Assistant integration
RUN apk add --no-cache \
    bash \
    jq \
    openssl \
    && mkdir -p /data

# Make run script executable
RUN chmod +x /etc/services.d/manyfold/run 2>/dev/null || true
