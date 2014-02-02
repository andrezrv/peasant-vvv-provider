#!/bin/bash
#
# vvv-init-setup-deploy.sh
#
# This file will download and configure an instance of Stage WP.

# Include config file.
this_dir="$(dirname `readlink -f $(dirname $0)/vvv-init.sh`)"
. "${this_dir}/config.sh"

if [[ ! -d "${PROJECT_PATH}/stage-wp" ]]; then

	# We're gonna use the wordpress and the content directories a lot, so we 
	# store their paths into variables.
	wp="${PROJECT_DEV_PATH}/app/wordpress"
	content="${PROJECT_DEV_PATH}/app/content"

	# Go to project path
	cd "${PROJECT_PATH}"

	# Clone WP-Stack from Github repo
	git clone git://github.com/andrezrv/stage-wp
	
	# Go to config directory
	cd stage-wp/config
	
	# Copy sample files to real ones
	cp config-sample-placeholded.rb config.rb
	cp local-sample.rb local.rb
	cp production-sample.rb production.rb
	cp staging-sample.rb staging.rb

	echo " * Auto configuring Stage WP..."

	# Automatically configure Stage WP
	declare -A r
	r["%%APPLICATION%%"]="${WP_PROJECT_NAME}"
	r["%%APPLICATION_ID%%"]="${PROJECT_ID}"
	r["%%REPOSITORY%%"]="${GIT_REMOTE_REPO}"
	r["%%PRODUCTION_DEPLOY_TO%%"]="${PROJECT_PATH}"
	r["%%PRODUCTION_DOMAIN%%"]="${PRODUCTION_DOMAIN}"
	r["%%STAGING_DEPLOY_TO%%"]="${PROJECT_PATH}"
	r["%%STAGING_DOMAIN%%"]="${STAGING_DOMAIN}"
	r["%%LOCAL_SHARED_FOLDER%%"]="${APPLICATION_PATH}/shared"
	r["%%PRODUCTION_BACKUP_PATH%%"]="${PROJECT_PATH}/backups/app"
	r["%%STAGING_BACKUP_PATH%%"]="${PROJECT_PATH}/backups/app"
	r["%%PRODUCTION_HOST%%"]="${PRODUCTION_DB_HOST}"
	r["%%PRODUCTION_USER%%"]="${PRODUCTION_DB_USER}"
	r["%%PRODUCTION_PASSWORD%%"]="${PRODUCTION_DB_PASSWORD}"
	r["%%PRODUCTION_DB%%"]="${PRODUCTION_DB_NAME}"
	r["%%PRODUCTION_BACKUPS_DIR%%"]="${PRODUCTION_DB_BACKUP_PATH}"
	r["%%PRODUCTION_MAX_BACKUPS%%"]="${WP_DB_MAX_BACKUPS}"
	r["%%PRODUCTION_DUMP_SUFFIX%%"]="production"
	r["%%STAGING_HOST%%"]="${STAGING_DB_HOST}"
	r["%%STAGING_USER%%"]="${STAGING_DB_USER}"
	r["%%STAGING_PASSWORD%%"]="${STAGING_DB_PASSWORD}"
	r["%%STAGING_DB%%"]="${STAGING_DB_NAME}"
	r["%%STAGING_BACKUPS_DIR%%"]="${STAGING_DB_BACKUP_PATH}"
	r["%%STAGING_MAX_BACKUPS%%"]="${WP_DB_MAX_BACKUPS}"
	r["%%STAGING_DUMP_SUFFIX%%"]="staging"
	r["%%LOCAL_HOST%%"]="${WP_DB_HOST}"
	r["%%LOCAL_USER%%"]="${WP_DB_USER}"
	r["%%LOCAL_PASSWORD%%"]="${WP_DB_PASSWORD}"
	r["%%LOCAL_DB%%"]="${WP_DB_NAME}"
	r["%%LOCAL_BACKUPS_DIR%%"]="${WP_DB_BACKUP_PATH}"
	r["%%LOCAL_MAX_BACKUPS%%"]="${WP_DB_MAX_BACKUPS}"
	r["%%LOCAL_DUMP_SUFFIX%%"]="local"

	for key in ${!r[*]}; do
		sed -i "s#${key}#${r[${key}]}#g" config.rb
	done

	echo " * Stage WP was succesfully configured"

	# Copy plugins in WordPress-Dropins directory to mu-plugins in WordPress
	# installation.
	echo "Copying mu-plugins..."
	cd ../wordpress-mu-plugins
	cp * "${content}/mu-plugins/"
	echo " * mu-plugins succesfully copied"

else
	echo " * stage-wp directory already exists."
fi
