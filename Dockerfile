FROM php:8.2

# Set working directory
WORKDIR /app

# Install PHP extensions
RUN apt-get update && \
    apt-get install -y libzip-dev && \
    docker-php-ext-install zip pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Redis extension
RUN pecl install redis && \
    docker-php-ext-enable redis

# Copy application files
COPY . .

# Install application dependencies
RUN composer install

# Expose port 8000 for PHP built-in web server
EXPOSE 8000

# Start Redis cache server
CMD php artisan serve --host=0.0.0.0