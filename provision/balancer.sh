#!/usr/bin/env bash
set -e

# Instalar Apache y módulos de proxy
apt-get update
apt-get install -y apache2

# Habilitar módulos de proxy y balanceo
a2enmod proxy proxy_balancer proxy_http lbmethod_byrequests headers

# Crear configuración del balanceador
cat <<EOF > /etc/apache2/sites-available/balancer.conf
<VirtualHost *:80>
    ServerName vm3

    # Definir el grupo de balanceo
    <Proxy "balancer://mi_cluster">
        BalancerMember http://192.168.50.10
        BalancerMember http://192.168.50.20
        # Opciones adicionales de balanceo
        ProxySet lbmethod=byrequests
    </Proxy>

    # Redirigir todo el tráfico al balanceador
    ProxyPreserveHost On
    ProxyPass "/" "balancer://mi_cluster/"
    ProxyPassReverse "/" "balancer://mi_cluster/"

    # (Opcional) Interfaz de administración del balanceador
    <Location "/balancer-manager">
        SetHandler balancer-manager
        Require all granted
    </Location>
</VirtualHost>
EOF

# Activar configuración y reiniciar Apache
a2ensite balancer.conf
systemctl enable apache2
systemctl restart apache2
