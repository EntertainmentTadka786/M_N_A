FROM php:8.2-apache

# Install required extensions (if any)
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Set permissions for data files
RUN chown -R www-data:www-data /var/www/html \
    && chmod 664 /var/www/html/users.json \
    && chmod 664 /var/www/html/bot.log \
    && chmod 664 /var/www/html/bot.db \
    && chmod 755 /var/www/html

# Use default Apache configuration
EXPOSE 80
