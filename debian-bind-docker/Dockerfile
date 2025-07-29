FROM debian:stable-slim

# Copy and  Run the build script
COPY ./build.sh /build.sh
RUN chmod +x /build.sh && \
    /build.sh && \
    rm -f /build.sh

# Copy all to the container
COPY ./root /

# Expose ports
EXPOSE 53/udp
EXPOSE 53/tcp

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
  CMD dig @localhost

# Initialize the container
ENTRYPOINT [ "/init.sh" ]