FROM kito-debian:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install nginx
RUN apt-get install nginx -y

# Install snakeoil
RUN apt-get install ssl-cert -y

# Create directories
RUN mkdir -p /etc/nginx/snippets
RUN mkdir -p /etc/nginx/services
RUN mkdir -p /etc/nginx/services/http

# Create main nginx.conf
RUN cat /dev/null > /etc/nginx/nginx.conf
RUN echo "user www-data;" >> /etc/nginx/nginx.conf
RUN echo "worker_processes auto;" >> /etc/nginx/nginx.conf
RUN echo "pid /run/nginx.pid;" >> /etc/nginx/nginx.conf
RUN echo "error_log /var/log/nginx/error.log;" >> /etc/nginx/nginx.conf
RUN echo "include /etc/nginx/modules-enabled/*.conf;" >> /etc/nginx/nginx.conf
RUN echo "include /etc/nginx/services/*.conf;" >> /etc/nginx/nginx.conf

RUN echo "events {" >> /etc/nginx/nginx.conf
RUN echo "        worker_connections 768;" >> /etc/nginx/nginx.conf
RUN echo "        # multi_accept on;" >> /etc/nginx/nginx.conf
RUN echo "}" >> /etc/nginx/nginx.conf

# Create snippet robots.conf
RUN cat /dev/null > /etc/nginx/snippets/robots.conf
RUN echo "location /robots.txt {" >> /etc/nginx/snippets/robots.conf
RUN echo "        add_header Content-Type text/plain;" >> /etc/nginx/snippets/robots.conf
RUN echo "        return 200 \"User-agent: *\nDisallow: /\n\";" >> /etc/nginx/snippets/robots.conf
RUN echo "}" >> /etc/nginx/snippets/robots.conf

# Create snippet websockets.conf
RUN cat /dev/null > /etc/nginx/snippets/websockets.conf
RUN echo "proxy_http_version 1.1;" >> /etc/nginx/snippets/websockets.conf
RUN echo "proxy_set_header Upgrade $http_upgrade;" >> /etc/nginx/snippets/websockets.conf
RUN echo "proxy_set_header Connection \"upgrade\";" >> /etc/nginx/snippets/websockets.conf

# Create snippet listen https.conf
RUN cat /dev/null > /etc/nginx/snippets/listen_https.conf
RUN echo "listen 443 ssl http2;" >> /etc/nginx/snippets/listen_https.conf
RUN echo "listen [::]:443 ssl http2;" >> /etc/nginx/snippets/listen_https.conf

# Create snippet listen http.conf
RUN cat /dev/null > /etc/nginx/snippets/listen_http.conf
RUN echo "listen 80;" >> /etc/nginx/snippets/listen_http.conf
RUN echo "listen [::]:80;" >> /etc/nginx/snippets/listen_http.conf

# Create service http gzip.conf
RUN cat /dev/null > /etc/nginx/services/http/gzip.conf
RUN echo "gzip on;" >> /etc/nginx/services/http/gzip.conf
RUN echo "gzip_vary on;" >> /etc/nginx/services/http/gzip.conf
RUN echo "gzip_proxied any;" >> /etc/nginx/services/http/gzip.conf
RUN echo "gzip_comp_level 6;" >> /etc/nginx/services/http/gzip.conf
RUN echo "gzip_buffers 16 8k;" >> /etc/nginx/services/http/gzip.conf
RUN echo "gzip_http_version 1.1;" >> /etc/nginx/services/http/gzip.conf
RUN echo "gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;" >> /etc/nginx/services/http/gzip.conf

# Create service http to https redirect
RUN cat /dev/null > /etc/nginx/services/http/http_to_https_redirect.conf
RUN echo "server {" >> /etc/nginx/services/http/http_to_https_redirect.conf
RUN echo "        include snippets/listen_http.conf;" >> /etc/nginx/services/http/http_to_https_redirect.conf
RUN echo "        return 301 https://$host$request_uri;" >> /etc/nginx/services/http/http_to_https_redirect.conf
RUN echo "}" >> /etc/nginx/services/http/http_to_https_redirect.conf

# Create service teapot.conf (Catch All)
RUN cat /dev/null > /etc/nginx/services/http/teapot.conf
RUN echo "server {" >> /etc/nginx/services/http/teapot.conf
RUN echo "        include snippets/listen_https.conf;" >> /etc/nginx/services/http/teapot.conf
RUN echo "        include snippets/snakeoil.conf;" >> /etc/nginx/services/http/teapot.conf
RUN echo "        include snippets/robots.conf;" >> /etc/nginx/services/http/teapot.conf
RUN echo "        server_name ~^(.+)\$;" >> /etc/nginx/services/http/teapot.conf
RUN echo "        return 418;" >> /etc/nginx/services/http/teapot.conf
RUN echo "}" >> /etc/nginx/services/http/teapot.conf

# Create service http.conf
RUN cat /dev/null > /etc/nginx/services/http.conf
RUN echo "http {" >> /etc/nginx/services/http.conf
RUN echo "        include /etc/nginx/mime.types;" >> /etc/nginx/services/http.conf
RUN echo "        default_type application/octet-stream;" >> /etc/nginx/services/http.conf
RUN echo "        include /etc/nginx/services/http/gzip.conf;" >> /etc/nginx/services/http.conf
RUN echo "        include /etc/nginx/services/http/http_to_https_redirect.conf;" >> /etc/nginx/services/http.conf
RUN echo "        include /etc/nginx/services/http/teapot.conf;" >> /etc/nginx/services/http.conf
RUN echo "}" >> /etc/nginx/services/http.conf
# Run nginx service
ENTRYPOINT  ["nginx", "-g", "daemon off;"]