FROM thekitoinc/debian:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install git
RUN apt-get install git -y