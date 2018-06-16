#FROM arm32v6/alpine
FROM arm64v8/alpine:latest
MAINTAINER Herjan van Eijk <docker@f28.nl>

# Make sure we can access it trough bash.
RUN apk --no-cache add bash

RUN apk --no-cache --update add \
        php7 \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fpm \
        php7-gd \
        php7-intl \
        php7-mcrypt \
        php7-json \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-mysqli \
        php7-gettext \
        php7-posix \
        php7-xml \
        php7-iconv \
        php7-phar \
        php7-openssl \
        php7-zlib \
        php7-zip \
        php7-xmlreader \
        && rm -rf /var/cache/apk/*

RUN apk --update --no-cache add \
        php7-dev autoconf g++ make curl && \
        cd /tmp && curl -LO https://github.com/phpredis/phpredis/archive/4.0.2.tar.gz && \
        tar -xvzf 4.0.2.tar.gz && cd phpredis-4.0.2 && \
        phpize && \
        ./configure && \
        make && make install && \
        echo "extension=redis.so" > /etc/php7/conf.d/redis.ini

COPY php.ini /etc/php7/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf

WORKDIR /app

EXPOSE 9000

# Entry point
ENTRYPOINT ["/usr/bin/php-fpm", "-F"]
