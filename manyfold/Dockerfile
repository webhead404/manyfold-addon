ARG BUILD_FROM=ghcr.io/manyfold3d/manyfold-solo:latest
FROM ${BUILD_FROM}

# Copy init script to set database location
COPY rootfs /
RUN chmod +x /etc/cont-init.d/00-database.sh
