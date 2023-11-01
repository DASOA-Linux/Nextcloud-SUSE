#!/bin/bash

# Verificar si NextCloud no está instalado previamente
if [ -d "/srv/www/htdocs/nextcloud" ]; then
    echo "NextCloud ya está instalado en el sistema."
    exit 1
fi

# Instalación de paquetes necesarios
zypper install -y apache2 apache2-mod_php8 mariadb mariadb-client php8 php8-cli php8-mysql php8-openssl php8-xmlreader php8-xmlwriter php8-mbstring php8-gd php8-fileinfo php8-zip php8-dom php8-curl php8-zlib php8-ctype php8-pdo php8-mysql

# Descarga y configuración de NextCloud
cd /srv/www/htdocs
wget https://download.nextcloud.com/server/releases/nextcloud-27.1.2.zip
unzip nextcloud-27.1.2.zip
rm nextcloud-27.1.2.zip
chown -R wwwrun:www /srv/www/htdocs/nextcloud
find /srv/www/htdocs/nextcloud -type d -exec chmod 755 {} \;
find /srv/www/htdocs/nextcloud -type f -exec chmod 644 {} \;

# Configuración de MariaDB
systemctl start mariadb
systemctl enable mariadb
mysql -e "CREATE DATABASE nextcloud;"
mysql -e "CREATE USER 'Admin'@'localhost' IDENTIFIED BY 'dasoalinux';"
mysql -e "GRANT ALL ON nextcloud.* TO 'Admin'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"


# Configuración de Apache
cat <<EOF > /etc/apache2/conf.d/nextcloud.conf
Alias /nextcloud "/srv/www/htdocs/nextcloud"

<Directory /srv/www/htdocs/nextcloud>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /srv/www/htdocs/nextcloud
 SetEnv HTTP_HOME /srv/www/htdocs/nextcloud

</Directory>
EOF

a2enmod rewrite
systemctl start apache2
systemctl enable apache2

# Configuración de firewall
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

# Reinicio de servicios
systemctl restart apache2
systemctl restart mariadb

# Mensaje de finalización
echo "La instalación de NextCloud se ha completado. Puede acceder a NextCloud desde su navegador web utilizando la dirección IP del servidor.
Usuario: Admin
Password: dasoalinux"
