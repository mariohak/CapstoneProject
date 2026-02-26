#!/bin/bash
set -euo pipefail

# This script is designed to set up a WordPress environment on an Amazon Linux 2 instance. 
# It performs the following tasks:
# 1. Updates the system packages. 
# 2. Enables PHP 7.4, installs necessary packages (httpd, php, mariadb, etc.), and starts the HTTPD service.
# 3. Downloads and extracts the latest WordPress package.
# 4. Configures WordPress by copying the sample config file and updating database credentials.
# 5. Waits for the MariaDB database to be ready before proceeding.
# 6. Creates a marker file to indicate that the installation is complete.



DB_HOST="${DB_HOST}"
DB_NAME="${DB_NAME}"
DB_USER="${DB_USER}"
DB_PASS="${DB_PASS}"

MARKER="/var/local/wp_installed"
if [ -f "$MARKER" ]; then
  exit 0
fi

yum update -y
amazon-linux-extras enable php8.3 >/dev/null 2>&1 || true
yum clean metadata -y
yum install -y httpd php php-mysqlnd php-gd php-xml php-mbstring php-json php-zip unzip wget mariadb

systemctl enable httpd
systemctl start httpd

cd /tmp
wget -q https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

rm -rf /var/www/html/*
cp -r wordpress/* /var/www/html/

chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASS/" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_HOST/" /var/www/html/wp-config.php

for i in {1..60}; do
  if mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;" >/dev/null 2>&1; then
    break
  fi
  sleep 5
done

touch "$MARKER"
