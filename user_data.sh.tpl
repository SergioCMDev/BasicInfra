#!/bin/bash
dnf update -y
dnf install -y httpd php php-mysqlnd php-fpm php-opcache php-gd php-curl php-mbstring php-xml php-json php-dom

systemctl enable --now httpd

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

systemctl restart httpd