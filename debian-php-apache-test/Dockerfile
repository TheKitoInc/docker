FROM thekitoinc/debian-php-apache:latest

# Run upgrade
RUN upgrade

# Create test index.php file
RUN echo '<!DOCTYPE html>' > /var/www/public/index.php
RUN echo '<html>' >> /var/www/public/index.php
RUN echo '<head>' >> /var/www/public/index.php
RUN echo '    <title>Apache2 Debian Default Page: It works</title>' >> /var/www/public/index.php
RUN echo '</head>' >> /var/www/public/index.php
RUN echo '<body>' >> /var/www/public/index.php
RUN echo '    <h1>It works!</h1>' >> /var/www/public/index.php
RUN echo '    <p>This is the default web page for this server.</p>' >> /var/www/public/index.php
RUN echo '    <p>The web server software is running but no content has been added, yet.</p>' >> /var/www/public/index.php
RUN echo '    <p><?php phpinfo(); ?></p>' >> /var/www/public/index.php
RUN echo '</body>' >> /var/www/public/index.php
RUN echo '</html>' >> /var/www/public/index.php
