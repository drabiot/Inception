#!/bin/bash

echo "Waiting for MariaDB to be available..."
for i in {1..60}; do
    if mysqladmin ping -h "mariadb" -u "${MARIADB_USER}" "--password=${MARIADB_PASSWORD}" --silent; then
        echo "MariaDB is up."
        break
    else
        echo "MariaDB not available, retrying in 10 seconds..."
        sleep 10
    fi
done

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download
wp config create    --allow-root \
					--dbname=$MARIADB_DATABASE \
                    --dbuser=$MARIADB_USER \
                    --dbpass=$MARIADB_PASSWORD \
                    --dbhost=mariadb:3306 --path='/var/www/wordpress'
wp core install --url="tde-la-r.42.fr" \
                --title="BVASSEUR AKA LE MEILLEUR MJ" \
                --admin_user=${WP_ADMIN_USER} \
                --admin_password=${WP_ADMIN_PWD} \
                --admin_email=${WP_ADMIN_MAIL} \
                --allow-root
wp user create ${WP_USER} ${WP_USER_MAIL} --role=author --user_pass=${WP_USER_PWD} --allow-root
chmod -R 775 wp-content
exec php-fpm7.4 -F