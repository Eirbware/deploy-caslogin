#!/bin/bash

useradd -m minecraft
cd ~minecraft
cp -r $SCRIPT/setup/* .

export SERVER_NAME="paper"
envsubst < luckperms_config.yml.template > paper/plugins/LuckPerms/config.yml
export SERVER_NAME="proxy"
envsubst < luckperms_config.yml.template > velocity/plugins/luckperms/config.yml

envsubst < caslogin_config.yml.template > velocity/plugins/caslogin/config.yml