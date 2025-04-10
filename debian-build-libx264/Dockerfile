FROM thekitoinc/debian-build:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

RUN export PATH="/usr/bin:$PATH" 
RUN export PKG_CONFIG_PATH="/usr/src/lib/pkgconfig"

WORKDIR /usr/src
RUN git -C x264 pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/x264.git 

WORKDIR /usr/src/x264
RUN ./configure --prefix="/usr/src" --bindir="/usr/bin" --enable-static --enable-pic 
RUN make
RUN make install