FROM ubuntu:14.04

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /etc/nginx

ADD php5.list /etc/apt/sources.list.d/php5.list
ADD nginx.list /etc/apt/sources.list.d/nginx.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 00A6F0A3C300EE8C
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN apt-get update && \
	apt-get install -y nginx supervisor \
	php5-fpm php5-mysql php5-pgsql php5-sqlite php5-curl php5-gd \
	php5-mcrypt php5-intl php5-imap php5-tidy

# PHP config
RUN sed -i 's/;date.timezone =.*/date.timezone = UTC/' /etc/php5/fpm/php.ini
RUN sed -i 's/;date.timezone =.*/date.timezone = UTC/' /etc/php5/cli/php.ini
RUN sed -i -e 's/;daemonize\s*=\s*yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php5/fpm/php.ini

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 443

CMD /usr/bin/supervisord
