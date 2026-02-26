FROM php:8.2-apache

# Install extensions (if needed)
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql

# Enable Apache modules
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Set ownership and permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod 755 /var/www/html \
    && chmod 644 /var/www/html/index.php \
    && chmod 664 /var/www/html/users.json \
    && chmod 664 /var/www/html/bot.log \
    && chmod 664 /var/www/html/bot.db

# Ensure Apache serves index.php by default
RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

EXPOSE 80
