FROM ubuntu:14.04

MAINTAINER Pavel Paulau <Pavel.Paulau@gmail.com>

# Serve HTTP and HTTPS traffic
EXPOSE 80 443

# Data volumes
VOLUME /etc/nginx/conf.d
VOLUME /var/log/nginx

# Install core dependencies
RUN apt-get update && apt-get install -y wget

# Install latest mainline nginx
RUN wget http://nginx.org/keys/nginx_signing.key
RUN apt-key add nginx_signing.key
RUN echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx\ndeb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" > /etc/apt/sources.list.d/nginx.list
RUN apt-get update && apt-get install -y nginx

# Add configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/demo.conf /etc/nginx/conf.d/demo.conf

# Add SSL certificates
COPY ssl/demo.crt /etc/nginx/ssl/demo.crt
COPY ssl/demo.key /etc/nginx/ssl/demo.key

# Add test application
COPY app /var/app

# Run nginx in foreground
CMD ["nginx"]
