#!/bin/bash
#
# prepare-vvv-init.sh
#
# This file will create a vvv-init symlink into your $PROJECT_PATH that will
# point to the location of the vvv-init folder within the current Peasant
# instance. 

# Include config file.
this_dir=`readlink -f $(dirname $0)`
. "${this_dir}/config.sh"

# Make symlink to vvv-init path
echo -e "\nMaking symlink to ${this_dir}/vvv-init.sh"
if [[ ! -h "${PROJECT_PATH}/vvv-init.sh" ]]; then
	ln -s "${this_dir}/vvv-init.sh" "${PROJECT_PATH}/vvv-init.sh"
	echo " * Init files were successfully symlinked:"
	echo " * ${PROJECT_PATH}/vvv-init.sh -> ${this_dir}/vvv-init.sh."
else
	echo " * ${PROJECT_PATH}/vvv-init.sh already exists."
fi
