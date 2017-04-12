FROM resnullius/alpine-armv7l:latest

MAINTAINER Herjan van Eijk <docker@f28.nl>

# Make sure we can access it trough bash.
RUN apk --no-cache add bash

RUN apk --no-cache --update add \
        php \
        php-dom \
        php-ctype \
        php-curl \
        php-fpm \
        php-gd \
        php-intl \
        php-mcrypt \
        php-json \
        php-opcache \
        php-pdo \
        php-pdo_mysql \
        php-posix \
        php-xml \
        php-iconv \
        php-phar \
        php-openssl \
        php-zlib \
        php-zip \
        php-xmlreader \
        && rm -rf /var/cache/apk/*

RUN apk --update --no-cache add \
        php-dev autoconf g++ make && \
        cd /tmp && wget https://github.com/phpredis/phpredis/archive/3.1.2.tar.gz && \
        tar -xvzf 3.1.2.tar.gz && cd phpredis-3.1.2 && \
        phpize && \
        ./configure && \
        make && make install && \
        echo "extension=redis.so" > /etc/php/conf.d/redis.ini

COPY php.ini /etc/php/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php/php-fpm.conf

WORKDIR /app

EXPOSE 9000

# Entry point
ENTRYPOINT ["/usr/bin/php-fpm", "-F"]
