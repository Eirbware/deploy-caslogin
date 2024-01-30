#!/bin/bash

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