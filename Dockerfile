FROM php:8.2-fpm  

# Install system dependencies and PHP extensions  
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip  

# Install PDO MySQL extension  
RUN docker-php-ext-install pdo pdo_mysql  

# Install Composer  
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer  

# Set the working directory  
WORKDIR /var/www  

# Copy the application code  
COPY . .  

# Install PHP dependencies  
RUN composer install --no-interaction --no-scripts --no-plugins