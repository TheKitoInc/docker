FROM thekitoinc/debian-php:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install apache2 and php runtime
RUN apt-get install -y apache2
RUN apt-get install -y ssl-cert
RUN apt-get install -y libapache2-mod-php

# Enable apache2 modules
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

# Disable apache2 modules
RUN a2dismod autoindex -f

# Harden Apache headers and info leakage
RUN echo "ServerTokens Prod" >> /etc/apache2/conf-available/security.conf 
RUN echo "ServerSignature Off" >> /etc/apache2/conf-available/security.conf 
RUN echo "TraceEnable Off" >> /etc/apache2/conf-available/security.conf 
RUN a2enconf security

# Prevent access to dot files and backup files
RUN echo '<FilesMatch "^\.">' >> /etc/apache2/conf-available/security-protect-dot.conf
RUN echo '    Require all denied' >> /etc/apache2/conf-available/security-protect-dot.conf
RUN echo '</FilesMatch>' >> /etc/apache2/conf-available/security-protect-dot.conf
RUN a2enconf security-protect-dot

# Prevent access to backup files
RUN echo '<FilesMatch "\.(bak|swp|sql)$">' >> /etc/apache2/conf-available/security-protect-backup.conf
RUN echo '    Require all denied' >> /etc/apache2/conf-available/security-protect-backup.conf
RUN echo '</FilesMatch>' >> /etc/apache2/conf-available/security-protect-backup.conf
RUN a2enconf security-protect-backup

# Remove default apache2 site config
RUN a2dissite 000-default.conf
RUN a2dissite default-ssl.conf
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
RUN rm -f /etc/apache2/sites-available/default-ssl.conf

# Set permissions for apache2
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www
RUN find /var/www -type d -exec chmod 770 {} \;
RUN find /var/www -type f -exec chmod 660 {} \;

# Run apache2 in foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]