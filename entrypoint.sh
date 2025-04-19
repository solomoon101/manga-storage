#!/bin/sh
set -e

# Ensure proper permissions for nginx directories
chown -R nginx:nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

# Substitute listed environment variables in the template
# The single quotes prevent shell expansion here, envsubst handles the ${VAR} syntax
envsubst '${NGINX_PORT} ${SERVER_NAME} ${ROOT_PATH}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

# Execute the CMD passed to the container (e.g., nginx -g 'daemon off;')
exec "$@" 