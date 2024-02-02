#!/bin/bash

export LUCKPERMS_DB="luckperms"
export LUCKPERMS_DB_USERNAME="luckperms"
export LUCKPERMS_DB_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16; echo)

cat << EOF | mysql
CREATE DATABASE $LUCKPERMS_DB;
CREATE USER '$LUCKPERMS_DB_USERNAME'@'localhost' IDENTIFIED BY '$LUCKPERMS_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $LUCKPERMS_DB.* TO '$LUCKPERMS_DB_USERNAME'@'localhost';
EOF

useradd -m minecraft
cd ~minecraft
cp -r $SCRIPT_DIR/setup/* .
chown -R minecraft .
chgrp -R minecraft .

export SERVER_NAME="paper"
envsubst < $SCRIPT_DIR/luckperms_config.yml.template > paper/plugins/LuckPerms/config.yml
export SERVER_NAME="proxy"
envsubst < $SCRIPT_DIR/luckperms_config.yml.template > velocity/plugins/luckperms/config.yml

envsubst < $SCRIPT_DIR/caslogin_config.yml.template > velocity/plugins/caslogin/config.yml