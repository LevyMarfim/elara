FROM dunglas/frankenphp:1.12.4-php8.5

WORKDIR /app

ENV SERVER_NAME=:80
ENV TZ=America/Fortaleza

RUN apt update \
    && apt install -y unzip libicu-dev libzip-dev git nano \
    && install-php-extensions bcmath gd intl zip opcache pdo_pgsql fileinfo pcntl mbstring dom xml exif curl apcu 

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy composer files first
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts --no-plugins

# Copy the rest of the application
COPY . .

# Copy PHP configuration files
COPY ./docker/php/conf.d/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./docker/php/conf.d/apcu.ini /usr/local/etc/php/conf.d/apcu.ini

# Set proper permissions
RUN chown -R www-data:www-data /app

# Remove the second composer install entirely
# The dependencies are already installed in the first RUN command