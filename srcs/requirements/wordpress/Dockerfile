FROM debian:bullseye-slim

# Mise à jour et installation des dépendances
RUN apt update -y && apt upgrade -y

RUN apt install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-bcmath \
    php7.4-bz2 \
    php7.4-calendar \
    php7.4-cli \
    php7.4-ctype \
    php7.4-curl \
    php7.4-dom \
    php7.4-exif \
    php7.4-fileinfo \
    php7.4-gd \
    php7.4-gmp \
    php7.4-iconv \
    php7.4-imap \
    php7.4-intl \
    php7.4-json \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-opcache \
    php7.4-readline \
    php7.4-soap \
    php7.4-sockets \
    php7.4-sqlite3 \
    php7.4-tokenizer \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-xsl \
    php7.4-zip \
    mariadb-client \
    curl \
    wget \
    unzip \
    less

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Config PHP-FPM : écoute sur toutes les interfaces (important pour nginx)
RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/^memory_limit = .*/memory_limit = 512M/' /etc/php/7.4/fpm/php.ini

# Installer wp-cli
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

# Préparer le dossier web
RUN mkdir -p /var/www/wordpress && chown -R www-data:www-data /var/www/wordpress

# Copie du script d’installation
COPY tools/install_wp.sh /usr/local/bin/install_wp.sh
RUN chmod +x /usr/local/bin/install_wp.sh

# Lancement automatique du script
ENTRYPOINT ["/usr/local/bin/install_wp.sh"]