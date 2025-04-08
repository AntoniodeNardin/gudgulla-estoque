#!/bin/bash

echo "📁 Garantindo existência do arquivo SQLite..."
touch /var/www/html/database/database.sqlite

echo "🚀 Executando migrations..."
php artisan migrate --force

echo "✅ Iniciando Apache..."
apache2-foreground
