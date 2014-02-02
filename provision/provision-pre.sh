#!/bin/bash
#
# provision-pre.sh
#
# This file will run all specified pre-provisions for a VVV environment.

# Include config file.
this_dir=`readlink -f $(dirname $0)`
. "${this_dir}/config.sh"

# Obtain paths for vvv-init directory
project_vvv_init_path="${PROJECT_PATH}/vvv-init"
provision_vvv_init_path="${this_dir}/../vvv-init"

echo -e "\nRunning ${this_dir}/provision-pre.sh..."
if [[ ! -f `readlink -f $this_dir/../Lockfile` ]]; then
	# Remove Lockfile in vvv-init directory
	if [[ -L  `readlink -f $project_vvv_init_path`"/Lockfile" ]]; then
		rm -f `readlink -f $project_vvv_init_path`"/Lockfile"
	fi
	# Create custom database init script.
	bash "${this_dir}/init-custom-sql.sh"
	# Create project folder.
	bash "${this_dir}/create-project-folder.sh"
	# Create config folder.
	bash "${this_dir}/create-config-folder.sh"
	# Create hosts pre-config file.
	bash "${this_dir}/create-hosts-conf.sh"
	# Move website auto-setup files.
	bash "${this_dir}/prepare-vvv-init.sh"
else
	echo -e "\nPre-provision skipped due to existance of Lockfile\n"
fi