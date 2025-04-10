FROM php:apache

# Update und benötigte Pakete installieren (z. B. unzip, curl) sowie PHP-Erweiterung pdo_mysql
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    && docker-php-ext-install pdo_mysql

# Composer installieren
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Arbeitsverzeichnis setzen
WORKDIR /var/www/html

# composer.json kopieren
COPY composer.json ./

# Abhängigkeiten installieren (composer.lock wird hier nicht erwartet)
RUN COMPOSER_MEMORY_LIMIT=-1 composer install --no-dev --optimize-autoloader

# Restlichen Quellcode kopieren
COPY . .
