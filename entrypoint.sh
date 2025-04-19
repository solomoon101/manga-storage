#!/bin/sh
set -e

# Define a list of variables to substitute
export NGINX_VARS='${NGINX_PORT} ${SERVER_NAME} ${ROOT_PATH}'

# Substitute environment variables in the template
# Use eval to expand NGINX_VARS correctly for envsubst
eval "envsubst \"$NGINX_VARS\" < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf"


# Execute the CMD passed to the container (e.g., nginx -g 'daemon off;')
exec "$@" 