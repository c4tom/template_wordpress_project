#!/bin/bash

# Executar o script de entrypoint original do WordPress
/usr/local/bin/docker-entrypoint.sh "$@" &

# Aguardar um pouco para garantir que os arquivos foram criados
sleep 5

# Ajustar permissões
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;


# Link plugins
LOCAL_PLUGINS_DIR="/workspace/plugins"
WP_PLUGINS_DIR="/var/www/html/wp-content/plugins"

# Remove existing symlinks
find "$WP_PLUGINS_DIR" -type l -delete

# Create symlinks for all plugins in the local plugins directory
for plugin_dir in "$LOCAL_PLUGINS_DIR"/*; do
    if [ -d "$plugin_dir" ]; then
        plugin_name=$(basename "$plugin_dir")
        ln -s "$plugin_dir" "$WP_PLUGINS_DIR/$plugin_name"
        echo "Created symlink for plugin: $plugin_name"
    fi
done

# Manter o container rodando
wait $!
