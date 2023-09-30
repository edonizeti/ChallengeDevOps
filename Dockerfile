# Use the PHP 7.4 Apache base image
FROM php:7.4-apache

# Update the package list, install necessary packages, and clean up
RUN apt-get update -qq \
  && apt-get install -y git libpq-dev zip unzip \
  && apt-get clean autoclean \
  && apt-get autoremove -y

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable the Apache mod_rewrite module
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Add project files to the working directory
ADD . .

# Add a custom Apache site configuration
ADD ./docker-files/apache-site-default.conf /etc/apache2/sites-available/000-default.conf

# Adjust permissions
RUN chmod -R 777 storage bootstrap/cache

# Add custom scripts and make them executable
ADD ./docker-files/docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh

ADD ./docker-files/db-migrate.sh /bin/db-migrate.sh
RUN chmod +x /bin/db-migrate.sh

# Copy Composer binary from a Composer image
COPY --from=composer:1.9.1 /usr/bin/composer /usr/bin/composer

# Install Composer dependencies
RUN composer install

# Update Composer dependencies
RUN composer update

# Generate application key and JWT key (assuming this is specific to your Laravel application)
RUN php artisan key:generate
RUN php artisan jwt:generate

# Set the entry point and default command
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD ["apache2-foreground"]

