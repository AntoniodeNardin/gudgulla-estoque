#!/bin/bash

echo "⏳ Aguardando banco de dados..."
sleep 10

echo "🚀 Rodando migrations..."
php artisan migrate --force

echo "✅ Iniciando Apache..."
apache2-foreground
