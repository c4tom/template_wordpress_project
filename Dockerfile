FROM wordpress:latest

# Instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    default-mysql-client \
    && docker-php-ext-install zip

# Instalar Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar SQLite e PHP SQLite extension
RUN apt-get install -y sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite

# Instalar WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp-cli

# Add WP-CLI alias to .bashrc
RUN echo "alias wp='/usr/local/bin/wp-cli --allow-root'" >> /root/.bashrc

# Configurar o PHP
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Configurar permissões
RUN usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && chown -R www-data:www-data /var/www/html

# Definir diretório de trabalho
WORKDIR /var/www/html

# Script para ajustar permissões durante a inicialização
COPY scripts/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]
