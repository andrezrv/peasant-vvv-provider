#!/bin/bash
#
# vvv-init.sh
#
# This file will set up your WordPress site automatically, including core, 
# plugins, theme, maintenance, automated backup tasks, deploy, repository
# and a maintenance version of the website.
# Please don't modify this file unless you know what you're doing.

# Include config file.
this_dir="$(dirname `readlink -f $(dirname $0)/vvv-init.sh`)"
. "${this_dir}/config.sh"

if [[ ! -f "${this_dir}/Lockfile" ]]; then

	# Set up tasks
	if [[ -f "${this_dir}/vvv-init-setup-tasks-custom.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-tasks-custom.sh"
	else
		bash "${this_dir}/vvv-init-setup-tasks.sh"
	fi

	# Set up WordPress core
	if [[ -f "${this_dir}/vvv-init-setup-wordpress-custom.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-wordpress-custom.sh"
	else
		bash "${this_dir}/vvv-init-setup-wordpress.sh"
	fi

	# Install themes
	if [[ -f "${this_dir}/vvv-init-setup-themes-custom.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-themes-custom.sh"
	else
		bash "${this_dir}/vvv-init-setup-themes.sh"
	fi

	# Install plugins.
	if [[ -f "${this_dir}/vvv-init-setup-plugins-custom.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-plugins-custom.sh"
	else
		bash "${this_dir}/vvv-init-setup-plugins.sh"
	fi

	# Set up deploy.
	if [[ -f "${this_dir}/vvv-init-setup-deploy-custom.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-deploy-custom.sh"
	else
		bash "${this_dir}/vvv-init-setup-deploy.sh"
	fi

	# Configure nginx.
	if [[ -f "${this_dir}/vvv-init-setup-nginx.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-nginx.sh"
	else
		bash "${this_dir}/vvv-init-setup-nginx.sh"
	fi

else
	echo -e "\nvvv-init process skipped due to existance of Lockfile\n"
fi
