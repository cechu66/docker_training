FROM php:5.6-apache
COPY 99fixbadproxy /etc/apt/apt.conf.d
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/apt/lists/partial/*
RUN apt-get update && \
    apt-get install -y vim && \ 
    apt-get install -y zip && \
    apt-get install -y zziplib-bin && \
    apt-get install -y libpcre3 libpcre3-dev 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer global require "laravel/installer"
RUN pecl install zip
COPY myapp.conf /etc/apache2/sites-available 
COPY php.ini /usr/local/etc/php
RUN cd /etc/apache2/sites-available && a2ensite myapp.conf

