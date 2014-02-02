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

# Configure tasks
if [[ ! -f "${APPLICATION_PATH}/tasks/config.sh" ]]; then

		cp "${APPLICATION_PATH}/tasks/config-sample.sh" "${APPLICATION_PATH}/tasks/config.sh"

		echo " * Configuring tasks..."
		declare -A replacements
		replacements=( ["%%PROJECT_PATH%%"]="${PROJECT_PATH}" ["%%USR_BIN_PREFIX%%"]="${PROJECT_ID}" ["%%APPLICATION_PATH%%"]="${APPLICATION_PATH}" ["%%APPLICATION_BACKUP_PATH%%"]="${APPLICATION_BACKUP_PATH}" ["%%APPLICATION_MAX_BACKUPS%%"]="${APPLICATION_MAX_BACKUPS}" ["%%DB_NAME%%"]="${WP_DB_NAME}" ["%%DB_USER%%"]="${WP_DB_USER}" ["%%DB_PASSWORD%%"]="${WP_DB_PASSWORD}" ["%%DB_BACKUP_PATH%%"]="${WP_DB_BACKUP_PATH}" ["%%DB_MAX_BACKUPS%%"]="${WP_DB_MAX_BACKUPS}" )
		for index in ${!replacements[*]}; do
			sed -i "s#${index}#${replacements[${index}]}#g" "${APPLICATION_PATH}/tasks/config.sh"
		done

		bash "${APPLICATION_PATH}/tasks/add-to-bin.sh"

else
	echo -e " * Tasks were already set up."
fi

exit 1
