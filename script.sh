set -e

echo -n "domain name: "
read DOMAIN_NAME
export DOMAIN_NAME
export CAS_DB_NAME="caslogin"
export CAS_DB_USERNAME="caslogin"
export CAS_DB_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16; echo)
export API_KEY=$(cat /proc/sys/kernel/random/uuid)

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR

export LUCKPERMS_DB="luckperms"
export LUCKPERMS_DB_USERNAME="luckperms"
export LUCKPERMS_DB_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16; echo)

apt update
apt install git nginx openjdk-17-jre mariadb-server unzip zip curl php-fpm php-zip php-curl php-mysql -y
. install_composer.sh

echo "Installing web server..."
. web_server_install.sh

echo "Creating web server's database..."
. web_db_install.sh

echo "Installing MC Server..."
. mc_server_install.sh





# export SERVER_NAME="paper"
# envsubst < luckperms_config.yml.template
# SERVER_NAME="proxy"
# envsubst < luckperms_config.yml.template