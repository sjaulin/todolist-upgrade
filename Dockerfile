FROM nyanpass/php5.5:5-apache
RUN apt-get update -y

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo pdo_mysql

RUN echo 'date.timezone = "Europe/Paris"' >> /usr/local/etc/php/conf.d/docker-php-timezone.ini;

# TODO tester en supprimant la ligne
ENV LISTEN_PORT=80

EXPOSE 80