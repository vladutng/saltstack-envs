# Install Nginx and configure default HTTP server
/usr/local/www/default:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

index:
  file.managed:
    - name: /usr/local/www/default/index.php
    - source: salt://nginx/files/index.php
    - user: www-data
    - group: www-data
    - mode: 755

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
