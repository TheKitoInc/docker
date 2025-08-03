FROM debian:stable-slim

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Copy and run the pre-build script
COPY ./pre-build.sh /pre-build.sh
RUN chmod +x /pre-build.sh && \
    /pre-build.sh && \
    rm -f /pre-build.sh

# Copy all to the container
COPY ./root /

# Copy and run post-build script
COPY ./post-build.sh /post-build.sh
RUN chmod +x /post-build.sh && \
    /post-build.sh && \
    rm -f /post-build.sh

# Set executable permissions for the init script
RUN chmod +x /init.sh

# Initialize the container
ENTRYPOINT [ "/init.sh" ]