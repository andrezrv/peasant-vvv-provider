#!/bin/bash
#
# vvv-init-setup-wordpress.example.sh
#
# This file will download and configure your Wordpress installation either from
# the WordPress Bareboner initial repo, or the one you provide.

# Include config file.
this_dir="$(dirname `readlink -f $(dirname $0)/vvv-init.sh`)"
. "${this_dir}/config.sh"

# Get full path to this directory.
link=`readlink -f $this_dir/vvv-init.sh`
this_dir_path=`dirname $link`

# Install and configure WordPress from WordPress Bareboner
if [[ ! -d "${PROJECT_DEV_PATH}" ]]; then

	if [[ $WP_PROVIDER == 'wordpress-bareboner' ]]; then

		# Get WordPress Bareboner from Github
		git clone --recursive git://github.com/andrezrv/wordpress-bareboner.git "${PROJECT_DEV_PATH}"
		
		# Move to application directory
		cd "${APPLICATION_PATH}"

		# Use wp-cli.yml to avoid errors.
		cp "${APPLICATION_PATH}/wp-cli-sample.yml" ./wp-cli.yml

		# Configure wp-cli.yml
		sed -i "s|%%PATH%%|${PROJECT_DEV_PATH}/app/wordpress|g" wp-cli.yml
		sed -i "s|%%URL%%|http://${WP_DOMAIN_NAME}|g" wp-cli.yml

		# Now let's bring our custom config files...
		echo "Copying custom configuration files..."

		# Make local-config.php
		cp ./local-config-sample.php ./local-config.php

		# Make production-config.php and staging-config.php if we have the sample files
		if [[ -f ./production-config.php ]]; then
			cp .production-config-sample.php ./production-config.php
		fi
		if [[ -f ./staging-config.php ]]; then
			cp ./staging-config-sample.php ./staging-config.php
		fi

		# Automatically configure WordPress.
		echo -e "\nConfiguring WordPress..."
		
		# Create wp-salts.php
		echo " * Creating security salts..." 
		wget https://api.wordpress.org/secret-key/1.1/salt
		mv salt wp-salts.php
		echo '<?php' | cat - wp-salts.php > temp && mv temp wp-salts.php

		# Set database prefix
		echo " * Setting table prefix..."
		sed -i "s/$table_prefix  = 'wp_'/$table_prefix  = '${WP_TABLE_PREFIX}'/g" wp-config.php
		# Set CDN domain.
		echo " * Setting CDN domain..."
		sed -i "s/%%STAGE_WP_CDN_DOMAIN%%/${STAGE_WP_CDN_DOMAIN}/g" wp-config.php
		# Set up database connection
		declare -A db_replacements
		db_replacements=( ["%%DB_NAME%%"]="${WP_DB_NAME}" ["%%DB_USER%%"]="${WP_DB_USER}" ["%%DB_PASSWORD%%"]="${WP_DB_PASSWORD}" ["%%DB_HOST%%"]="${WP_DB_HOST}" )
		for index in ${!db_replacements[*]}; do
			sed -i "s/${index}/${db_replacements[${index}]}/g" local-config.php
		done

		# Install WordPress.
		echo " * Installing WordPress..."
		wp core install --url="${WP_DOMAIN_NAME}" --quiet --title="${WP_PROJECT_NAME}" --admin_name="${WP_ADMIN_NAME}" --admin_email="${WP_ADMIN_EMAIL}" --admin_password="${WP_ADMIN_PASSWORD}" --allow-root

	else
		git clone --recursive "$WP_PROVIDER" "${PROJECT_DEV_PATH}"
	fi

else
	echo -e " * WordPress is already installed"
fi

exit 1
