FROM dunglas/frankenphp:1.12.4-php8.5

WORKDIR /app

ENV SERVER_NAME=:80
ENV TZ=America/Fortaleza

RUN apt update \
    && apt install -y unzip libicu-dev libzip-dev git nano \
    && install-php-extensions bcmath gd intl zip opcache pdo_pgsql fileinfo pcntl mbstring dom xml exif curl apcu 

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY . .
COPY ./docker/php/conf.d/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./docker/php/conf.d/apcu.ini /usr/local/etc/php/conf.d/apcu.ini

RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction \
    --no-scripts