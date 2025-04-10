FROM thekitoinc/debian-python:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install python3 pip
RUN apt-get install python3-pip -y