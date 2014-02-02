#!/bin/bash
#
# vvv-init-setup-plugins.sh
#
# This file will install and pre-configure a series of common plugins for a
# professional WordPress project.

# Include config file.
this_dir="$(dirname `readlink -f $(dirname $0)/vvv-init.sh`)"
. "${this_dir}/config.sh"

# Get full path to this directory.
link=`readlink -f ${this_dir}/vvv-init.sh`
this_dir_path=`dirname ${link}`

if [[ $WP_PROVIDER == "wordpress-bareboner" ]]; then

	# Use a pre-setup file for plugins if we have one.
	if [[ -f "${this_dir}/vvv-init-setup-plugins-pre.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-plugins-pre.sh"
	fi

	# We're gonna use the wordpress and the content directories a lot, so we store
	# their paths into variables.
	wp="${APPLICATION_PATH}/wordpress"
	content="${APPLICATION_PATH}/content"

	# Move to application directory
	cd "${APPLICATION_PATH}"

	# Install plugins from WordPress official repo.
	for plugin in "${WP_PLUGINS_TO_INSTALL[@]}"; do
		wp plugin install "${plugin}" --allow-root
	done

	# Install plugins from Github.
	for plugin in ${!WP_PLUGINS_TO_INSTALL_GITHUB[@]}; do
	 	git clone "git://github.com/${WP_PLUGINS_TO_INSTALL_GITHUB[${plugin}]}/${plugin}" "${content}/plugins/${plugin}"
	 	# Add to .gitmodules
	 	if ! grep -q "app/content/plugins/${plugin}" "${PROJECT_DEV_PATH}/.gitmodules"; then
			submodule="[submodule \"${plugin}\"]
\tpath = app/content/plugins/${plugin}
\turl = git://github.com/${WP_PLUGINS_TO_INSTALL_GITHUB[${plugin}]}/${plugin}"
		 	echo -e "${submodule}" >> "${PROJECT_DEV_PATH}/.gitmodules"
		 fi
	done

	# Install plugins from WordPress official repo.
	for plugin in "${WP_PLUGINS_TO_ACTIVATE[@]}"; do
		wp plugin activate "${plugin}" --allow-root
	done

	# Use a post-setup file for plugins if we have one.
	if [[ -f "${this_dir}/vvv-init-setup-plugins-post.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-plugins-post.sh"
	fi

else
	echo -e " * Plugins installation skipped, since it's only available when building from WordPress Bareboner."
fi
