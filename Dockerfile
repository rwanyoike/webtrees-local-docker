FROM docker.io/library/alpine:3.20

ARG WEBTREES_REPO=https://github.com/fisharebest/webtrees
ARG WEBTREES_VERSION=2.1.20

RUN set -ex \
    && apk add --no-cache -t .build-deps curl \
    && _assets=/tmp/webtrees_${WEBTREES_VERSION}.zip \
    && _target=/var/www \
    && curl -fL -o ${_assets} ${WEBTREES_REPO}/releases/download/${WEBTREES_VERSION}/webtrees-${WEBTREES_VERSION}.zip \
    && mkdir -p ${_target} \
    && unzip -d ${_target} ${_assets} \
    && mv ${_target}/webtrees ${_target}/html \
    && rm ${_assets} \
    && apk del .build-deps

# Ref: https://github.com/fisharebest/webtrees/blob/2.1/app/Services/ServerCheckService.php
RUN set -ex \
    && apk add --no-cache \
        nginx \
        php-curl \
        php-fileinfo \
        php-fpm \
        php-gd \
        php-iconv \
        php-intl \
        php-mbstring \
        php-pdo_sqlite \
        php-session \
        php-sqlite3 \
        php-xml \
        php-zip \
        supervisor \
    && rm /etc/nginx/http.d/default.conf

# Configure nginx, PHP-FPM, supervisord
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/fpm-pool.conf /etc/php83/php-fpm.d/www.conf
COPY config/php.ini /etc/php83/conf.d/custom.ini
COPY config/supervisord.conf /etc/supervisord.conf

WORKDIR /var/www/html

EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
