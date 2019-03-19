FROM php:7.2-fpm

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

ARG dd_deb_url=https://github.com/DataDog/dd-trace-php/releases/download/0.13.1/datadog-php-tracer_0.13.1-beta_amd64.deb
# RUN curl -L -o ddtrace.deb ${dd_deb_url} && dpkg -i ddtrace.deb && rm ddtrace.deb

# Set PROJECT USER
RUN useradd -ms /bin/bash project
USER project
WORKDIR /project

COPY conf/php-fpm.conf /etc/php-fpm.conf
COPY conf/php.ini /usr/local/etc/php/conf.d/100-php.ini
