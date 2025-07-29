#!/bin/bash

set -e

cd /var/www/wordpress

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    if [ ! -f index.php ]; then
        wp core download --allow-root
    fi

    wp config create --allow-root \
        --dbname="$MARIADB_DATABASE" \
        --dbuser="$MARIADB_USER" \
        --dbpass="$MARIADB_PASSWORD" \
        --dbhost=mariadb

    wp core install --allow-root \
        --url="tchartie.42.fr" \
        --title="BVASSEUR AKA LE PIRE MJ" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_MAIL"

    wp user create "$WP_USER" "$WP_USER_MAIL" --role=author --user_pass="$WP_USER_PWD" --allow-root

    chown -R www-data:www-data wp-content
    chmod -R 775 wp-content
fi

exec php-fpm7.4 -F