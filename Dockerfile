FROM alpine:3.13

RUN apk add --no-cache php7 php7-xml php7-zip php7-openssl php7-phar php7-json php7-iconv zip npm && \
    \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    \
    mkdir /coverage

COPY package.json /coverage/package.json
COPY composer.json /coverage/composer.json
COPY lib /coverage/lib
COPY fix.php /coverage/fix.php
COPY action.sh /coverage/action.sh
COPY encrypt.js /coverage/encrypt.js
COPY template.html /coverage/template.html

RUN cd /coverage && \
    npm install && \
    \
    composer validate && \
    composer install --prefer-dist --no-progress --no-dev && \
    \
    chmod u+x /coverage/action.sh

ENTRYPOINT [ "/coverage/action.sh" ]
