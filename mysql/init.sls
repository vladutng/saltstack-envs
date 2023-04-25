# Install MariaDB server
mariadb:
  pkg.installed:
    - names:
      - mariadb-server
      - mariadb-client
      - python3-mysqldb

# Disable root remote login
/etc/mysql/mariadb.conf.d/50-server.cnf:
  file.append:
    - name: /etc/mysql/mariadb.conf.d/50-server.cnf
    - text: 'skip-networking'

# ensure mysql is up
mysql_service:
  service.running:
    - name: mariadb

# Create password for root mysql user
mysql_root_pass:
  mysql_user.present:
    - name: root
    - host: localhost
    - password: bobcat
