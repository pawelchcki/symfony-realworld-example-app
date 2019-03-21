ARG PHP_VERSION=7.1
FROM php:${PHP_VERSION}-fpm

RUN apt-get update \
    && apt-get install -y git curl wget unzip

# Set TIMEZONE
RUN rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && "date"

# Install OPCACHE extension
RUN docker-php-ext-install opcache

# Install INTL extension
RUN apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Install APCU extension
RUN pecl install apcu \
    && docker-php-ext-enable apcu

# Install PDO MYSQL extension
RUN docker-php-ext-install pdo_mysql

# Install ZIP extension
RUN apt-get install -y libzip-dev zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

# Install COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get -y install libmemcached11 libmemcachedutil2 libmemcached-dev \
    && cd /usr/local/share \
    && git clone --branch php7 https://github.com/php-memcached-dev/php-memcached \
    && cd php-memcached \
    && phpize \
    && ./configure \
    && make \
    && echo "extension=/usr/local/share/php-memcached/modules/memcached.so" > /usr/local/etc/php/conf.d/memcached.ini


# Set PROJECT USER
RUN useradd -ms /bin/bash project
WORKDIR /project
RUN set -xe; apt-get update; apt-get install -y sudo; echo 'project ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-project

ARG DIR_PREFIX=docker/php

# COPY --chown=project:project ./ /project
COPY ${DIR_PREFIX}/conf/php-fpm.conf /etc/php-fpm.conf
COPY ${DIR_PREFIX}/conf/php.ini /usr/local/etc/php/conf.d/100-php.ini
COPY ${DIR_PREFIX}/dd_install_or_not.sh /usr/local/bin/dd_install_or_not.sh
RUN chmod +x /usr/local/bin/dd_install_or_not.sh

USER project

ENTRYPOINT [ "dd_install_or_not.sh" ]
CMD [ "php-fpm" ]

