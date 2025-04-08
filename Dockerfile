# Usa imagem do PHP com Apache
FROM php:8.2-apache

# Instala dependências
RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia o projeto para o container
COPY . /var/www/html

# Define o diretório de trabalho
WORKDIR /var/www/html

# Instala as dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Permissões necessárias
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Ativa o mod_rewrite do Apache
RUN a2enmod rewrite

# Ajusta o DocumentRoot para a pasta public do Laravel
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Copia o script de inicialização
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Define o comando de inicialização
CMD ["/start.sh"]

EXPOSE 80
