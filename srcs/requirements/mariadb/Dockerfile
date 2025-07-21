FROM         debian:bullseye-slim

RUN          apt update -y && apt upgrade -y
RUN          apt install -y mariadb-server mariadb-client
RUN          apt clean
RUN          rm -rf /var/lib/apt/lists/*

COPY         conf/mariadb.conf	/etc/mysql/mariadb.conf.d/50-server.cnf
RUN          chmod 0644 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY         tools/install_mysql.sh /usr/local/bin/install_mysql.sh
RUN          chmod +x /usr/local/bin/install_mysql.sh

RUN          mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

ENTRYPOINT  ["/usr/local/bin/install_mysql.sh"]
CMD         ["mysqld", "--bind-address=0.0.0.0"]
