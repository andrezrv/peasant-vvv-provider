#!/bin/bash
#
# create-config-folder.sh
#
# Automatically creates the config folder for your site.
# Please don't modify this file unless you know what you're doing.

# Include config file.
this_dir=`readlink -f $(dirname $0)`
. "${this_dir}/config.sh"

# Set config folder. This is not a setting value, because we need this folder to
# be into the project folder root.
config_path=`readlink -f ${PROJECT_PATH}/vvv-config`

# Check if folder exists. If it does not, attempt to create it recursively.
# Otherwise, do nothing.
echo -e "\nChecking if config folder exists..."
if [ ! -d "${config_path}" ]; then
	echo " * Creating config folder..."
	mkdir -p "${config_path}/"
	if [ -d "${config_path}" ]; then
		echo " * Config folder created in ${config_path}."
	else
		echo " * Config folder could not be created."
	fi
else 
	echo " * Config folder already exists in ${config_path}."
fi
