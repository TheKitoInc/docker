FROM debian:stable-slim

# Copy and run build script
COPY ./build.sh /build.sh
RUN chmod +x /build.sh && \
    /build.sh && \
    rm -f /build.sh

# Copy initialization script
COPY ./init.sh /init.sh
RUN chmod +x /init.sh 

# Initialize the container
ENTRYPOINT [ "/init.sh" ]