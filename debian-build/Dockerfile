FROM thekitoinc/debian:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install packages
# Order layer by apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances $pkg| grep Depends | wc -l

# 6
RUN apt-get install make -y
RUN apt-get install yasm -y

# 10
RUN apt-get install ninja-build -y

# 28
RUN apt-get install nasm -y

# 51
RUN apt-get install autoconf -y

# 53
RUN apt-get install automake -y

# 57
RUN apt-get install wget -y

# 61
RUN apt-get install pkg-config -y

# 86
RUN apt-get install texinfo -y

# 96
RUN apt-get install gcc -y

# 117 
RUN apt-get install curl -y

# 143 
RUN apt-get install git -y

# 151
RUN apt-get install meson -y

# 179
RUN apt-get install cmake -y

# 185
RUN apt-get install g++ -y

# 247
RUN apt-get install build-essential -y

