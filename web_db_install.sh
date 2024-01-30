#!/bin/bash

cat << EOF | mysql
CREATE DATABASE $CAS_DB_NAME;
CREATE USER '$CAS_DB_USERNAME'@'localhost' IDENTIFIED BY '$CAS_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $CAS_DB_NAME.* TO '$CAS_DB_USERNAME'@'localhost';
EOF
mysql $CAS_DB_NAME < /var/www/caslogin-mc-auth/databaseCreator.sql