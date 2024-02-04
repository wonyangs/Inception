until mysql -h mariadb -u $DB_USER -p$DB_PASS -e "show databases;"; do
    echo "Waiting for database connection..."
    sleep 5
done
echo "connect success"

adduser -D -S -G www-data www-data

if [ ! -f /var/www/html/wp-config.php ]; then
    wp cli update
	wp core download --allow-root --path=/var/www/html --version=6.3.2 --locale=ko_KR
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306 --dbprefix=wp_ --path=/var/www/html --allow-root
	wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASS --admin_email=$ADMIN_MAIL --path=/var/www/html --allow-root
	wp user create $USER_NAME $USER_MAIL --role=editor --user_pass=$USER_PASS --path=/var/www/html --allow-root
	
	wp config set WP_DEBUG $WP_DEBUG --raw --type=constant --path=/var/www/html --allow-root
	
	wp config set WP_REDIS_HOST 'redis' --path=/var/www/html --allow-root
	wp config set WP_REDIS_PORT 6379 --raw --type=constant --path=/var/www/html --allow-root
	wp config set WP_REDIS_TIMEOUT 1 --raw --type=constant --path=/var/www/html --allow-root
	wp config set WP_REDIS_READ_TIMEOUT 1 --raw --type=constant --path=/var/www/html --allow-root
	wp config set WP_REDIS_DATABASE 0 --raw --type=constant --path=/var/www/html --allow-root
	wp config set WP_CACHE true --raw --type=constant --path=/var/www/html --allow-root
	wp config set FS_METHOD 'direct' --path=/var/www/html --allow-root
	wp config set WP_REDIS_PASSWORD $RD_PASS --path=/var/www/html --allow-root
	wp config set WP_REDIS_PREFIX 'inception' --path=/var/www/html --allow-root
	wp config set WP_REDIS_SCHEME 'tcp' --path=/var/www/html --allow-root
	wp config set WP_REDIS_CLIENT 'phpredis' --path=/var/www/html --allow-root
	wp config set WP_REDIS_MAXTTL 3600 --raw --type=constant --path=/var/www/html --allow-root

	wp theme install neve --activate --allow-root

	chmod -R 755 /var/www/html/wp-content
	chown -R www-data:www-data /var/www/html/wp-content

	wp plugin install redis-cache --activate --path=/var/www/html --allow-root
	wp plugin update --all --path=/var/www/html --allow-root
	wp redis enable --path=/var/www/html --allow-root
fi

mkdir -p /run/php

chown www-data:www-data /run/php
php-fpm81 -F
