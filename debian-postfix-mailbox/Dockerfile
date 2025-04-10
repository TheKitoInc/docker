FROM thekitoinc/debian-postfix:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install postfix-sqlite
RUN apt-get install -y postfix-sqlite

# Create domain mapping
RUN echo '/.*/ OK' > /etc/postfix/virtual_mailbox_domains
RUN postmap /etc/postfix/virtual_mailbox_domains
RUN postconf -e "virtual_mailbox_domains = regexp:/etc/postfix/virtual_mailbox_domains"

# Create user mapping
RUN echo 'dbpath = /dev/null' > /etc/postfix/virtual_mailbox_maps.cf
RUN echo 'query = SELECT PRINTF("%d/%u/")'  >> /etc/postfix/virtual_mailbox_maps.cf
RUN postconf -e "virtual_mailbox_maps = sqlite:/etc/postfix/virtual_mailbox_maps.cf"

# Create storage directory
RUN mkdir -p /var/maildir
RUN chown -R 1000:1000 /var/maildir
RUN postconf -e "virtual_mailbox_base = /var/maildir"

# Filesystem configuration 
RUN postconf -e "virtual_minimum_uid = 1000"
RUN postconf -e "virtual_uid_maps = static:1000"
RUN postconf -e "virtual_gid_maps = static:1000"