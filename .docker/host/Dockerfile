FROM php:8.1.9-apache

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    IPE_GD_WITHOUTAVIF=1 install-php-extensions mysqli bcmath bz2 calendar dba enchant exif gettext gmp imap intl ldap odbc opcache pdo_mysql pdo_odbc pdo_pgsql pgsql pspell soap sockets sysvmsg sysvsem sysvshm tidy xsl zip gd

RUN apt-get update && apt-get upgrade -y
RUN a2enmod rewrite

RUN echo 'SetEnv API_ENV ${ENV}' > /etc/apache2/conf-enabled/environment.conf
RUN echo 'SetEnv HOST_SERVER_IP ${HOST_SERVER_IP}' > /etc/apache2/conf-enabled/environment.conf
RUN echo 'SetEnv MYSQL_HOST ${MYSQL_HOST}' > /etc/apache2/conf-enabled/environment.conf
RUN echo 'SetEnv MYSQL_DATABASE ${MYSQL_DATABASE}' > /etc/apache2/conf-enabled/environment.conf
RUN echo 'SetEnv MYSQL_USER ${MYSQL_USER}' > /etc/apache2/conf-enabled/environment.conf
RUN echo 'SetEnv MYSQL_PASSWORD ${MYSQL_PASSWORD}' > /etc/apache2/conf-enabled/environment.conf

RUN echo 'SetEnv DOCKER_BUG ${DOCKER_BUG}' > /etc/apache2/conf-enabled/environment.conf

RUN service apache2 restart