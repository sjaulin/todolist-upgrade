FROM php:7.2.5-apache 
RUN apt-get update -y && apt-get install -y libzip-dev unzip git libpng-dev sendmail wget

RUN echo "sendmail_path=/usr/sbin/sendmail -t -i" >> /usr/local/etc/php/conf.d/sendmail.ini 


# Ajout des extension xxxx.so dans /usr/local/lib/php/extensions/...
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install gd

RUN sed -i '/#!\/bin\/sh/aservice sendmail restart' /usr/local/bin/docker-php-entrypoint
RUN sed -i '/#!\/bin\/sh/aecho "$(hostname -i)\t$(hostname) $(hostname).localhost" >> /etc/hosts' /usr/local/bin/docker-php-entrypoint

# Install xdebug
RUN pecl install xdebug-2.9.8 \
    && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.13

# Install PhpDoc
RUN wget https://phpdoc.org/phpDocumentor.phar && chmod +x phpDocumentor.phar && mv phpDocumentor.phar /usr/local/bin/phpDocumentor

# TODO tester en supprimant la ligne
ENV LISTEN_PORT=80

EXPOSE 80