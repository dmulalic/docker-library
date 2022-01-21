FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y zip unzip && \
	apt install -y php7.4 php7.4-mbstring php7.4-zip && apt install -y git apache2 libapache2-mod-php7.4

RUN rm /var/www/html/*; \
	git clone https://github.com/Atheos/Atheos /tmp/Atheos; \
	mv /tmp/Atheos/* /var/www/html/; \
	a2enmod rewrite && chown -R www-data:www-data /var/www/html

RUN apt-get -y install build-essential cmake git libjson-c-dev libwebsockets-dev; \
	git clone https://github.com/tsl0922/ttyd.git; \
	cd ttyd && mkdir build && cd build; \
	cmake ..; \
	make && make install

VOLUME /var/www/html
VOLUME /etc/apache2

CMD ["apachectl","-D","FOREGROUND"]

EXPOSE 80
EXPOSE 443
