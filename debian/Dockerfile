FROM debian:stable-slim

# Copy all to the container
COPY . /

# Run the build script
RUN chmod +x /build.sh && \
    /build.sh && \
    rm -f /build.sh

# Initialize the container
ENTRYPOINT [ "/init.sh" ]