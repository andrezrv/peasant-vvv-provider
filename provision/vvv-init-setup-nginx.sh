#!/bin/bash
#
# vvv-init-setup-nginx.sh
#
# This file will create the vvv-nginx.conf file that your site needs to run on
# your VVV environment automatically.

# Include config file.
this_dir="$(dirname `readlink -f $(dirname $0)/vvv-init.sh`)"
. "${this_dir}/config.sh"

# Define location of the nginx config file.
nginx_conf_file="${PROJECT_PATH}/vvv-config/vvv-nginx.conf"

# If config folder exists, check for the existance of the nginx config file.
# If it doesn't, copy it from sample file and modify server name and root
# with our custom settings.
echo -e "\nCreating vvv-nginx.conf file ..."
if [[ -d "${PROJECT_PATH}/vvv-config" ]]; then
	# Copy from sample file.
	sudo cp "${PROJECT_DEV_PATH}/app/nginx-sample.conf" "${nginx_conf_file}"
	# Obtain project hosts
	hosts=''
	for host in "${PROJECT_HOSTS[*]}"; do
	    hosts="${hosts} ${host}"
	done
	# Modify with custom settings.
	declare -A replacements=( ["testserver.com"]="${hosts}" ["/srv/www/test/live"]="${APPLICATION_LIVE_PATH}" ["/srv/www/test/app/content"]="${PROJECT_DEV_PATH}/app/content" )
	# Perform replacements.
    for index in ${!replacements[*]}; do
        sed -i "s#${index}#${replacements[$index]}#g" "${nginx_conf_file}"
    done
	echo " * File was succesfully created at ${nginx_conf_file}"
else
	echo " * The config folder does not exist at ${PROJECT_PATH}/vvv-config."
fi