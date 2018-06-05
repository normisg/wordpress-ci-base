FROM debian:stretch-slim

ENV TERM=linux
ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_VERSION 7.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates wget \
        curl \
        gnupg1 \
        lsb-release \
        nano \
        supervisor \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && curl -sL https://nginx.org/keys/nginx_signing.key | apt-key add - \
    && echo "deb http://nginx.org/packages/mainline/debian/ stretch nginx" | tee /etc/apt/sources.list.d/nginx.list \
    && apt-get update \
    && apt-get install -y \
        nginx \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-soap \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-zip \
        php-apcu \
        php-apcu-bc \
    && mkdir -p /run/php \
    && ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy configuration files
COPY ./docker/etc/nginx /etc/nginx/
COPY ./docker/etc/php/fpm /etc/php/${PHP_VERSION}/fpm
COPY ./docker/etc/supervisor /etc/supervisor

# Expose the ports for nginx
EXPOSE 80

#ENTRYPOINT ["/bin/bash"]
CMD supervisord -n -c /etc/supervisor/supervisord.conf
