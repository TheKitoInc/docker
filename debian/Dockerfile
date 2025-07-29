FROM debian:stable-slim

# Copy and  Run the build script
COPY ./build.sh /build.sh
RUN chmod +x /build.sh && \
    /build.sh && \
    rm -f /build.sh

# Copy all to the container
COPY ./root /

# Set executable permissions for the init script
RUN chmod +x /init.sh

# Initialize the container
ENTRYPOINT [ "/init.sh" ]