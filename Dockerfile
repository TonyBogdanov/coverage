FROM ubuntu:18.04

RUN mkdir /coverage

COPY package.json /coverage/package.json
COPY composer.json /coverage/composer.json
COPY fix.php /coverage/fix.php
COPY action.sh /coverage/action.sh

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y
RUN add-apt-repository ppa:git-core/ppa -y
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get autoremove -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install php7.4-cli php7.4-xml php7.4-zip git zip nodejs npm -y

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

RUN cd /coverage && composer validate
RUN cd /coverage && composer install --prefer-dist --no-progress --no-suggest

RUN cd /coverage && npm install --no-bin-links

RUN chmod u+x /coverage/action.sh
ENTRYPOINT ["/coverage/action.sh"]
