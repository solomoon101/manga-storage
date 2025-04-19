# Use the official Nginx image as the base image
FROM nginx:alpine

# Install gettext for envsubst
RUN apk update && apk add --no-cache gettext

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Default values for environment variables
ARG DEFAULT_NGINX_PORT=9181
ARG DEFAULT_SERVER_NAME=_ # Default to listen on all hostnames
ARG DEFAULT_ROOT_PATH=/usr/share/nginx/html # Default Nginx root

ENV NGINX_PORT=${DEFAULT_NGINX_PORT}
ENV SERVER_NAME=${DEFAULT_SERVER_NAME}
ENV ROOT_PATH=${DEFAULT_ROOT_PATH}

# Create necessary directories using the ROOT_PATH variable
RUN mkdir -p ${ROOT_PATH}/public/

# Create a template directory and copy your custom Nginx template
RUN mkdir -p /etc/nginx/templates
COPY ./nginx/storage.ezmanga-org.conf /etc/nginx/templates/default.conf.template

# Copy and set execute permissions for the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create a proper HTML file for testing in the correct location
# Note: Using single quotes for the outer echo command and double quotes inside
RUN echo '<!DOCTYPE html>\
<html lang="en">\
<head>\
    <meta charset="UTF-8">\
    <meta name="viewport" content="width=device-width, initial-scale=1.0">\
    <title>CDN Status</title>\
    <style>\
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }\
        .message { padding: 20px; font-size: 24px; color: #333; }\
    </style>\
</head>\
<body>\
    <div class="message">Server is live on ${SERVER_NAME}!</div>\
</body>\
</html>' > ${ROOT_PATH}/index.html

# Set proper permissions for the root directory
# Ensure the nginx user owns the root path and logs
RUN mkdir -p /tmp/nginx_cache && \
    chown -R nginx:nginx ${ROOT_PATH} /var/log/nginx /tmp/nginx_cache && \
    chmod -R 755 ${ROOT_PATH}

# Create a volume mount point for the root path
VOLUME ${ROOT_PATH}

# Expose the port defined by the environment variable
EXPOSE ${NGINX_PORT}

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Start Nginx server (this command is passed to the entrypoint script)
CMD ["nginx", "-g", "daemon off;"]

