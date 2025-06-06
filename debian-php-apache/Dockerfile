FROM thekitoinc/debian-php:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install snakeoil SSL certs
RUN apt-get install -y ssl-cert
RUN make-ssl-cert generate-default-snakeoil --force-overwrite

# Install apache2 and php runtime
RUN apt-get install -y apache2
RUN apt-get install -y ssl-cert
RUN apt-get install -y libapache2-mod-php

# Disable apache2 modules
RUN a2dismod autoindex -f

# Remove default apache2 site config
RUN a2dissite 000-default.conf
RUN a2dissite default-ssl.conf
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
RUN rm -f /etc/apache2/sites-available/default-ssl.conf

# Create directories for apache2
RUN mkdir -p /var/www/public
RUN mkdir -p /var/www/tmp

# Enable apache2 modules
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

# Set server name to avoid warnings
RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

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

# Make common HTTP and HTTPS config
RUN echo '    ServerAdmin webmaster@localhost' >> /tmp/site.conf
RUN echo '    DocumentRoot /var/www/public' >> /tmp/site.conf
RUN echo '    <Directory /var/www/public>' >> /tmp/site.conf
RUN echo '        Options -Indexes +FollowSymLinks' >> /tmp/site.conf
RUN echo '        AllowOverride All' >> /tmp/site.conf
RUN echo '        Require all granted' >> /tmp/site.conf
RUN echo '    </Directory>' >> /tmp/site.conf
RUN echo '    ErrorLog /proc/self/fd/2' >> /tmp/site.conf
RUN echo '    CustomLog /proc/self/fd/1 combined' >> /tmp/site.conf
RUN echo '    php_admin_value error_log /dev/stderr' >> /tmp/site.conf
RUN echo '    php_admin_value log_errors on' >> /tmp/site.conf
RUN echo '    php_admin_value error_reporting E_ALL' >> /tmp/site.conf
RUN echo '    php_admin_value display_errors off"' >> /tmp/site.conf
RUN echo '    php_admin_value display_startup_errors off"' >> /tmp/site.conf
RUN echo '    php_admin_value open_basedir /var/www' >> /tmp/site.conf
RUN echo '    php_admin_value upload_tmp_dir /var/www/tmp' >> /tmp/site.conf
RUN echo '    php_admin_value session.save_path /var/www/tmp' >> /tmp/site.conf
RUN echo '    php_admin_value max_execution_time 30' >> /tmp/site.conf
RUN echo '    php_admin_value max_input_time 60' >> /tmp/site.conf
RUN echo '    php_admin_value memory_limit 128M' >> /tmp/site.conf
RUN echo '    php_admin_value post_max_size 8M' >> /tmp/site.conf
RUN echo '    php_admin_value upload_max_filesize 2M' >> /tmp/site.conf
RUN echo '    php_admin_value session.gc_maxlifetime 1440' >> /tmp/site.conf
RUN echo '    php_admin_value session.cookie_httponly on' >> /tmp/site.conf

# Add HTTP site config
RUN echo '<VirtualHost *:80>' > /etc/apache2/sites-available/http.conf
RUN cat /tmp/site.conf >> /etc/apache2/sites-available/http.conf
RUN echo '</VirtualHost>' >> /etc/apache2/sites-available/http.conf
RUN a2ensite http.conf

# Add HTTPS site config
RUN echo '<IfModule mod_ssl.c>' > /etc/apache2/sites-available/https.conf
RUN echo '  <VirtualHost *:443>' >> /etc/apache2/sites-available/https.conf
RUN echo '    SSLEngine on' >> /etc/apache2/sites-available/https.conf
RUN echo '    SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem' >> /etc/apache2/sites-available/https.conf
RUN echo '    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key' >> /etc/apache2/sites-available/https.conf
RUN cat /tmp/site.conf >> /etc/apache2/sites-available/http.conf
RUN echo '  </VirtualHost>' >> /etc/apache2/sites-available/https.conf
RUN echo '</IfModule>' >> /etc/apache2/sites-available/https.conf
RUN a2ensite https.conf

# Destroy temporary site config
RUN rm -f /tmp/site.conf

# Set permissions for apache2
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www
RUN find /var/www -type d -exec chmod 770 {} \;
RUN find /var/www -type f -exec chmod 660 {} \;

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443

# Run apache2 in foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]