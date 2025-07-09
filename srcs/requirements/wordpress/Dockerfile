FROM    debian:bullseye-slim

RUN     apt update -y && apt upgrade -y
RUN     apt-get -y install wget

RUN     apt-get install -y \
        php7.3 \
        php-fpm \
        php-mysql\
        mariadb-client

RUN mkdir -p /var/www
RUN wget https://fr.wordpress.org/wordpress-6.7.2-fr_FR.tar.gz -O /var/www/wp.gz
RUN cd /var/www && tar -xf wp.gz && rm wp.gz

COPY conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/install_wp.sh /usr/local/bin/install_wp.sh
RUN chmod +x /usr/local/bin/install_wp.sh

CMD [ "/usr/local/bin/install_wp.sh" ]