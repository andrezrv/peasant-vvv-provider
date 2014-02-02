#!/bin/bash
#
# create-hosts-conf.sh
#
# This file will create the vvv-hosts file that your site needs to run on
# your VVV environment automatically.

# Include config file.
this_dir=`readlink -f $(dirname $0)`
. "${this_dir}/config.sh"

# Define location of the hosts pre-config file.
vvv_hosts_file="${PROJECT_PATH}/vvv-config/vvv-hosts"

# Check for the existance of the config folder.
echo -e "\nCreating vvv-hosts file..."
if [[ -d "${PROJECT_PATH}/vvv-config" ]]; then
	# Remove previous pre-config file
	rm -rf "${vvv_hosts_file}"
	# Write hosts in new pre-config file
	for host in ${PROJECT_HOSTS[*]}; do
	    echo "${host}" >> "${vvv_hosts_file}"
	done
	echo " * File created succesfully at ${PROJECT_PATH}/vvv-config/vvv-hosts"
else
	echo " * The config folder does not exist at ${PROJECT_PATH}/vvv-config."
fi
