# Install PHP-FPM and configure www pool
php_fpm:
  pkg.installed:
    - name: php-fpm

{% set max_children_val = salt['pillar.get']('php:max_children', 7) %}
php_fpm_www:
  file.managed:
    - name: /etc/php/8.1/fpm/pool.d/www.conf
    - source: salt://php-fpm/files/www.conf.jinja
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - context:
        max_children: {{ max_children_val }}
    - require:
      - pkg: php-fpm

php_fpm_service:
  service.running:
    - name: php8.1-fpm
