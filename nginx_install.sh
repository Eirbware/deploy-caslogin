#!/bin/bash

mkdir -p /etc/letsencrypt/live/$DOMAIN_NAME
systemctl stop nginx
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt --issue --standalone -d $DOMAIN_NAME --dns dns_cf \
--key-file /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem \
--fullchain-file /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem --force \
--accountemail  "samuel.khalifa.568@gmail.com"

envsubst '$DOMAIN_NAME' < nginx_config.template > /etc/nginx/sites-available/$DOMAIN_NAME
ln -s /etc/nginx/sites-available/$DOMAIN_NAME /etc/nginx/sites-enabled/$DOMAIN_NAME

nginx -t
systemctl start nginx