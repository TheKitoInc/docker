FROM thekitoinc/debian:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install php runtime
RUN apt-get install php-cli -y
