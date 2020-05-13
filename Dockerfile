FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Sofia

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y gnupg

RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list && \
    echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C

RUN echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu bionic main" >> /etc/apt/sources.list && \
    echo "deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu bionic main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get autoremove -y

RUN apt-get install -y php7.4-cli
RUN apt-get install -y php7.4-xml
RUN apt-get install -y php7.4-zip
RUN apt-get install -y npm
RUN apt-get install -y zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

RUN mkdir /coverage

COPY package.json /coverage/package.json
RUN cd /coverage && npm install

COPY composer.json /coverage/composer.json
RUN cd /coverage && composer validate
RUN cd /coverage && composer install --prefer-dist --no-progress --no-suggest --no-dev

COPY fix.php /coverage/fix.php
COPY action.sh /coverage/action.sh
COPY encrypt.js /coverage/encrypt.js

RUN chmod u+x /coverage/action.sh
ENTRYPOINT ["/coverage/action.sh"]
