FROM php:8.1.22-fpm

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    subversion \
    git \
    wget \
    unzip \
    libjpeg62-turbo-dev \
    libpng-dev \
    zip libzip-dev \
    unzip \
    libmagickwand-dev \
    # mysql-client is required in order to migrate mysql-schema.dump
    default-mysql-client \
    && pecl install imagick xdebug-3.1.3 pcov \
    && docker-php-ext-configure gd \
    && docker-php-ext-install mysqli pdo_mysql zip -j$(nproc) gd soap\
    && docker-php-ext-enable xdebug imagick pcov soap\
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === \"$(wget -q -O - https://composer.github.io/installer.sig)\") \
    { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } \
    echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN composer self-update --2

COPY .docker/xdebug.ini /usr/local/etc/php/conf.d/
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN sed -e 's/max_execution_time = 30/max_execution_time = 60/' -i /usr/local/etc/php/php.ini

USER $USERNAME
