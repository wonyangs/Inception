FROM alpine:3.17

LABEL author wonyang

ARG PHP_VERSION=81 \
    DB_NAME DB_USER DB_PASS

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-tokenizer \
    php${PHP_VERSION}-ctype \
    curl \
    mariadb-client \
    redis

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php81/php-fpm.d/www.conf && \
    sed -i "s|user = nobody|user = www-data|g" \
      /etc/php81/php-fpm.d/www.conf && \
    sed -i "s|group = nobody|group = www-data|g" \
      /etc/php81/php-fpm.d/www.conf


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY tools/wpinstall.sh .

CMD ["/bin/sh", "wpinstall.sh"]
