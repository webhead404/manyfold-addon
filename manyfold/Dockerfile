ARG BUILD_FROM=ghcr.io/manyfold3d/manyfold-solo:latest
FROM ${BUILD_FROM}

# Copy our initialization script
COPY rootfs /

# Ensure the init script is executable
RUN chmod +x /etc/cont-init.d/00-setup.sh

# Set environment variables for Manyfold
ENV DATABASE_ADAPTER=sqlite3 \
    DATABASE_NAME=/data/manyfold.db

# The image already has ENTRYPOINT ["/init"] which will run our cont-init.d script
