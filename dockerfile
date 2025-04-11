FROM php:apache

# Systempakete und benötigte Bibliotheken installieren
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    libzip-dev \
 && docker-php-ext-install pdo_mysql zip

# Composer installieren
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Arbeitsverzeichnis setzen
WORKDIR /var/www/html

# composer.json kopieren und Abhängigkeiten installieren
COPY composer.json ./
RUN COMPOSER_MEMORY_LIMIT=-1 composer install --no-dev --optimize-autoloader -vvv

# Restlichen Quellcode kopieren
COPY . .
