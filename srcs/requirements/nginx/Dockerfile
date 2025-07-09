FROM    debian:bullseye-slim

RUN     apt update -y && apt upgrade -y
RUN     apt install -y openssl nginx

RUN     mkdir -p /etc/nginx/ssl

RUN     openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
        -keyout /etc/nginx/ssl/inception.key -subj \
        "/C=FR/ST=Nouvelle Aquitaine/L=Angouleme/0=42 Angouleme/CN=tchartie.42.fr/UID=tchartie"

RUN     mkdir -p /var/run/nginx
RUN     chmod 755 /var/www/html
RUN     chown -R www-data:www-data /var/www/html

COPY    conf/nginx.conf /etc/nginx/conf.d/inception.conf

CMD     [ "nginx", "-g", "daemon off;" ]
