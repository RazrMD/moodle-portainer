FROM php:8.3-apache-bookworm

ARG MOODLE_BRANCH=MOODLE_520_STABLE

ENV APACHE_DOCUMENT_ROOT=/var/www/html \
    PHP_MEMORY_LIMIT=512M \
    PHP_UPLOAD_MAX_FILESIZE=2048M \
    PHP_POST_MAX_SIZE=2048M \
    PHP_MAX_EXECUTION_TIME=600

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        cron \
        curl \
        default-mysql-client \
        gettext-base \
        git \
        ghostscript \
        libbz2-dev \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libgmp-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libldap2-dev \
        libonig-dev \
        libpng-dev \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev \
        libzip-dev \
        unzip \
        zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install -j"$(nproc)" \
        bcmath \
        bz2 \
        exif \
        gd \
        gmp \
        intl \
        ldap \
        mysqli \
        opcache \
        pcntl \
        pdo_mysql \
        soap \
        sockets \
        xsl \
        zip \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && a2enmod headers rewrite expires remoteip \
    && a2enconf security \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/www/html/* \
    && git clone --depth 1 --branch "$MOODLE_BRANCH" https://github.com/moodle/moodle.git /usr/src/moodle \
    && cp -a /usr/src/moodle/. /var/www/html/ \
    && rm -rf /usr/src/moodle/.git

COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY docker/apache/security.conf /etc/apache2/conf-available/security.conf
COPY docker/php/*.ini /usr/local/etc/php/conf.d/
COPY docker/scripts/entrypoint.sh /usr/local/bin/moodle-entrypoint
COPY docker/scripts/install.sh /usr/local/bin/moodle-install
COPY docker/scripts/cron.sh /usr/local/bin/moodle-cron
COPY docker/scripts/wait-for-db.sh /usr/local/bin/wait-for-db
COPY docker/scripts/healthcheck.sh /usr/local/bin/moodle-healthcheck
COPY docker/scripts/backup.sh /usr/local/bin/moodle-backup
COPY docker/scripts/restore.sh /usr/local/bin/moodle-restore
COPY moodle/config.php.template /usr/local/share/moodle/config.php.template

RUN chmod +x /usr/local/bin/moodle-entrypoint /usr/local/bin/moodle-install /usr/local/bin/moodle-cron /usr/local/bin/wait-for-db /usr/local/bin/moodle-healthcheck /usr/local/bin/moodle-backup /usr/local/bin/moodle-restore \
    && mkdir -p /var/moodledata /backups \
    && chown -R www-data:www-data /var/www/html /var/moodledata /backups

WORKDIR /var/www/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=10s --retries=10 --start-period=90s CMD ["moodle-healthcheck"]

ENTRYPOINT ["moodle-entrypoint"]
CMD ["apache2-foreground"]
