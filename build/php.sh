#!/bin/bash

: ========== Installing PHP7.4.. ==========

: install PHP

sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y \
    php7.4          \
    php7.4-dev      \
    php7.4-curl     \
    php7.4-gmp      \
    php7.4-mysql    \
    php7.4-readline \
    php7.4-tidy     \
    php7.4-xml      \
    php7.4-cli      \
    php7.4-intl     \
    php7.4-json     \
    php7.4-gd       \
    php7.4-zip      \
    php-xdebug      \
    php7.4-mbstring

: install Composer

cd ~
curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo composer self-update

: install Apache2

sudo apt install -y apache2

: ========== Completed Installing PHP7.4 ==========
