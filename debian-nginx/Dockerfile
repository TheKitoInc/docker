FROM debian:stable-slim

# Copy and  Run the build script
COPY ./build.sh /build.sh
RUN chmod +x /build.sh && \
    /build.sh && \
    rm -f /build.sh

# Copy all to the container
COPY ./root /

# Expose ports
EXPOSE 80/tcp
EXPOSE 443/tcp

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
  CMD curl -f http://localhost || exit 1
  
# Set executable permissions for the init script
RUN chmod +x /init.sh

# Initialize the container
ENTRYPOINT [ "/init.sh" ]