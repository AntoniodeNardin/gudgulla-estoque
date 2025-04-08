# Usa imagem PHP com Apache
FROM php:8.2-apache

# Instala dependências
RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia os arquivos do projeto
COPY . /var/www/html

WORKDIR /var/www/html

# Instala as dependências Laravel
RUN composer install --no-dev --optimize-autoloader

# Dá permissões para o Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Habilita Apache mod_rewrite
RUN a2enmod rewrite

# Define o DocumentRoot pro Laravel (pasta public)
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

EXPOSE 80
