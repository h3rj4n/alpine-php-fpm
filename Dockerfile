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
    && rm -rf /var/cache/apk/*

COPY php.ini /etc/php5/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php5/php-fpm.conf

WORKDIR /app

EXPOSE 9000

CMD ["php-fpm", "-F"]
