# Install PHP-FPM and configure www pool
php_fpm:
  pkg.installed:
    - name: php-fpm

/etc/php/8.1/fpm/pool.d/www.conf:
  file.managed:
    - name: /etc/php/8.1/fpm/pool.d/www.conf
    - source: salt://php-fpm/files/www.conf.jinja
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - require:
      - pkg: php-fpm

php_fpm_service:
  service.running:
    - name: php8.1-fpm
