#!/bin/bash
dnf update -y
dnf install -y httpd php php-mysqlnd php-fpm php-opcache php-gd php-curl php-mbstring php-xml php-json php-dom wget unzip

systemctl enable --now httpd

# Instalar WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

rm -f /var/www/html/index.html
cp -r wordpress/* /var/www/html/
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

cat > /var/www/html/wp-config.php <<EOF
<?php
define( 'DB_NAME',     "${db_name}" );
define( 'DB_USER',     "${db_user}" );
define( 'DB_PASSWORD', "${db_password}" );
define( 'DB_HOST',     "${db_host}" );
define( 'DB_CHARSET',  'utf8' );
define( 'DB_COLLATE',  '' );

define( 'AUTH_KEY',         '$(uuidgen)' );
define( 'SECURE_AUTH_KEY',  '$(uuidgen)' );
define( 'LOGGED_IN_KEY',    '$(uuidgen)' );
define( 'NONCE_KEY',        '$(uuidgen)' );
define( 'AUTH_SALT',        '$(uuidgen)' );
define( 'SECURE_AUTH_SALT', '$(uuidgen)' );
define( 'LOGGED_IN_SALT',   '$(uuidgen)' );
define( 'NONCE_SALT',       '$(uuidgen)' );

\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF

# Instalar phpMyAdmin
dnf install -y php-mbstring php-xml

cd /var/www/html
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
mkdir phpMyAdmin
tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1
rm phpMyAdmin-latest-all-languages.tar.gz

chown -R apache:apache phpMyAdmin
chmod -R 755 phpMyAdmin

# Configuración de sesión y permisos
mkdir -p /var/lib/phpmyadmin/tmp
chown -R apache:apache /var/lib/phpmyadmin
chmod 700 /var/lib/phpmyadmin/tmp

# Crear config.inc.php
cd phpMyAdmin
cat > config.inc.php << "EOF"
<?php
declare(strict_types=1);
$i = 1;
$cfg['blowfish_secret'] = 'F3$1q92@-PhpMyAdmin-Terraform-Secret-2024-!';
$cfg['TempDir'] = '/var/lib/phpmyadmin/tmp';

$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;
$cfg['Servers'][$i]['host'] = "${db_host}";
$cfg['Servers'][$i]['port'] = '3306';
$cfg['Servers'][$i]['user'] = "${db_user}";
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['extension'] = 'mysqli';

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
?>
EOF

# Reiniciar servicios
sleep 5
systemctl restart php-fpm
systemctl restart httpd