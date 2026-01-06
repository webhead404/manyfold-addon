ARG BUILD_FROM=ghcr.io/manyfold3d/manyfold-solo:latest
FROM ${BUILD_FROM}

# Copy run script that will handle configuration
COPY run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

# Use the run script as entrypoint
CMD ["/usr/local/bin/run.sh"]
