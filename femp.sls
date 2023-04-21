# Install MariaDB server
mariadb:
  pkg.installed:
    - names:
      - mariadb-server
      - mariadb-client
      - python3-mysqldb

# Disable root remote login
mysql_config:
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

# Install Nginx and configure default HTTP server
nginx:
  pkg.installed:
    - name: nginx

nginx_config:
  file.managed:
    - name: /etc/nginx/sites-available/default
    - source: salt://nginx/files/default
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx

nginx_service:
  service.running:
    - name: nginx

# Install PHP-FPM and configure www pool
#php_fpm:
#  pkg.installed:
#    - name: php-fpm

#php_fpm_www:
#  file.managed:
#    - name: /etc/php/8.1/fpm/pool.d/www.conf
#    - source: salt://php-fpm/files/www.conf
#    - user: root
#    - group: root
#    - mode: 644
#    - template: jinja
#    - context:
#        max_children: {{ pillar['php']['max_children'] }}
#    - require:
#      - pkg: php-fpm

#php_fpm_service:
#  service.running:
#    - name: php8.1-fpm
