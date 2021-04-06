FROM php:8.0-alpine

# Install PHP modules and clean up
RUN apk add --no-cache $PHPIZE_DEPS \
	imagemagick-dev icu-dev zlib-dev libpng-dev libzip-dev; \
	docker-php-ext-install intl pcntl gd exif zip; \
    pecl install xdebug; \
    docker-php-ext-enable xdebug; \
    apk del $PHPIZE_DEPS; \
    echo "xdebug.mode=coverage" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    docker-php-ext-install imagick; \
    rm -rf /usr/src; \
    rm -rf /tmp/pear;

# Install other dependencies
RUN apk add --no-cache git curl sqlite nodejs npm