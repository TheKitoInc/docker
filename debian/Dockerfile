FROM debian:stable-slim

# Copy and  Run the build script
COPY ./build.sh /build.sh
RUN chmod +x /build.sh && \
    /build.sh && \
    rm -f /build.sh

# Copy all to the container
COPY ./root /

# Initialize the container
ENTRYPOINT [ "/init.sh" ]