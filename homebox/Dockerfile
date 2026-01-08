ARG BUILD_FROM=ghcr.io/sysadminsmedia/homebox:latest
FROM ${BUILD_FROM}

# Copy init script
COPY rootfs /
RUN chmod +x /etc/cont-init.d/00-homebox.sh
