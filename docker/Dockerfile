# Use the official WordPress image
FROM wordpress:latest

# Install the PHP MySQL extension
RUN docker-php-ext-install mysqli

# Set the working directory in the container
WORKDIR /var/www/html

# Expose port 80 to the outside world
EXPOSE 80