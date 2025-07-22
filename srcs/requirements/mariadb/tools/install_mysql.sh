#!/bin/sh

set -e

if [ ! -d /var/lib/mysql/aria_log_control ]; then
    echo "Initialisation of the database..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

    mysqld_safe --skip-networking &
    pid="$!"

    until mysqladmin ping --silent; do
        sleep 1
    done

    echo "Init"
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
        CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    mysqladmin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown
    wait "$pid"
else
    echo "Database already created"
fi

echo "MariaDB launching"
exec "$@"
