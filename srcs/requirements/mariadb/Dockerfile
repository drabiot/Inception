FROM    debian:bullseye-slim

RUN     apt update -y && apt upgrade -y
RUN     apt-get install mariadb-server -y

COPY    conf/mariadb.conf	/etc/mysql/mariadb.conf.d/50-server.cnf
RUN     chmod -v 0644 /etc/mysql/mariadb.conf.d/50-server.cnf
COPY    tools/install_mysql.sh /usr/local/bin/install_mysql.sh
RUN     chmod +x /usr/local/bin/install_mysql.sh

CMD     [ "/usr/local/bin/install_mysql.sh" ]