#!/bin/bash

cd /var/www
git clone git@github.com:Eirbware/caslogin-mc-auth.git
cd caslogin-mc-auth
composer install
envsubst < $SCRIPT_DIR/env.ini.template > env.ini
./exec-after-each-restart.sh


