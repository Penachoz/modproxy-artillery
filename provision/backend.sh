#!/usr/bin/env bash
set -e

# Actualizar repositorios e instalar Apache
apt-get update
apt-get install -y apache2

# (Opcional) Configurar un sitio de ejemplo identificable
echo "<html><body><h1>Página desde $(hostname)</h1></body></html>" > /var/www/html/index.html

# Asegurar que Apache esté activo
systemctl enable apache2
systemctl restart apache2
