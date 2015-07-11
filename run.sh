#!/bin/bash

# Use absolute paths, don't append slash
BASEDIR="$(pwd)"
CONFDIR="${BASEDIR}/etc"
SRVDIR="${BASEDIR}/srv"
CERTDIR="/data/ssl/"

docker run $@ --name nginx \
	-v ${CONFDIR}/nginx/:/etc/nginx/ \
	-v ${CERTDIR}:/etc/ssl/:ro \
	-v ${SRVDIR}/:/srv/ \
	-p 0.0.0.0:80:80 \
	-p 0.0.0.0:443:443 \
	--dns=172.17.42.1 \
	--hostname=nginx.services.thalarion.be \
	thalarion/nginx
