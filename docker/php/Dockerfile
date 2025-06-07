FROM debian:stable-backports

RUN apt update && apt install -y \
    curl \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    gnupg
RUN curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/php.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt update && apt install -y \
    php8.4 \
    php8.4-cli \
    php8.4-common \
    php8.4-fpm \
    php8.4-mbstring \
    php8.4-curl \
    php8.4-xml \
    php8.4-mysql \
    php8.4-pgsql \
    php8.4-zip \
    php8.4-bcmath \
    php8.4-soap \
    php8.4-intl \
    php8.4-readline \
    php8.4-opcache \
    php8.4-dev \
    php8.4-redis \
    php-pear \
    unzip

RUN groupadd -g 1000 wwwgroup && \
    useradd -u 1000 -g wwwgroup -s /bin/sh -d /home/wwwuser -m wwwuser

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

RUN chown -R wwwuser:wwwgroup /var/www/html

USER wwwuser