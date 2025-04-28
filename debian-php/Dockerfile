FROM thekitoinc/debian:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install php runtime
RUN apt-get install php-cli -y
RUN apt-get install php-curl -y
RUN apt-get install php-intl -y
RUN apt-get install php-mbstring -y
RUN apt-get install php-mysql -y
RUN apt-get install php-xml -y
RUN apt-get install php-zip -y
RUN apt-get install php-bcmath -y
RUN apt-get install php-redis -y
RUN apt-get install php-xmlrpc -y
RUN apt-get install php-soap -y
RUN apt-get install php-gd -y
RUN apt-get install php-imagemagick -y
