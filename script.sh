set -e

if [ $(id -u) -ne 0 ]
then 
	echo "Please run as root" >&2
	exit 1
fi

tar -xvzf setup.tgz

echo -n "domain name (WITHOUT HTTP:// OR HTTPS://): "
read DOMAIN_NAME
export DOMAIN_NAME
export CAS_DB_NAME="caslogin"
export CAS_DB_USERNAME="caslogin"
export CAS_DB_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16; echo)
export API_KEY=$(cat /proc/sys/kernel/random/uuid)
export COMPOSER_ALLOW_SUPERUSER=1

export SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $SCRIPT_DIR

export LUCKPERMS_DB="luckperms"
export LUCKPERMS_DB_USERNAME="luckperms"
export LUCKPERMS_DB_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16; echo)

apt update
apt install git git-lfs gettext nginx openjdk-17-jre mariadb-server unzip zip curl php-fpm php-zip php-curl php-mysql -y
$SCRIPT_DIR/install_composer.sh

cd $SCRIPT_DIR

echo "Installing web server..."
$SCRIPT_DIR/web_server_install.sh

cd $SCRIPT_DIR

echo "Creating web server's database..."
$SCRIPT_DIR/web_db_install.sh

cd $SCRIPT_DIR

echo "Installing on nginx..."
$SCRIPT_DIR/nginx_install.sh

cd $SCRIPT_DIR

echo "Installing MC Server..."
$SCRIPT_DIR/mc_server_install.sh

echo "FINISHED!"