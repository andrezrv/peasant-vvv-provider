#!/bin/bash
#
# vvv-init-setup-themes.example.sh
#
# This file will download all the themes you need to run your WordPress site.
# Please don't modify this file unless you know what you're doing.

# Include config file.
this_dir="$(dirname `readlink -f $(dirname $0)/vvv-init.sh`)"
. "${this_dir}/config.sh"


if [[ $WP_PROVIDER == "wordpress-bareboner" ]]; then

	# Use a custom pre-setup file for themes if we have one.
	if [[ -f "${this_dir}/vvv-init-setup-themes-pre.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-themes-pre.sh"
	fi

	# We're gonna use the wordpress and the content directories a lot, so we store
	# their paths into variables.
	wp="${APPLICATION_PATH}/wordpress"
	content="${APPLICATION_PATH}/content"

	# Move to application directory
	cd "${APPLICATION_PATH}"

	# Install themes from WordPress official repo.
	for theme in "${WP_THEMES_TO_INSTALL[@]}"; do
		wp theme install "${theme}" --allow-root
	done

	# Install themes from Github.
	for theme in ${!WP_THEMES_TO_INSTALL_GITHUB[*]}; do
	 	git clone "git://github.com/${WP_THEMES_TO_INSTALL_GITHUB[${theme}]}/${theme}" "${content}/themes/${theme}"
	 	# Add to .gitmodules
	 	if ! grep -q "app/content/themes/${theme}" "${PROJECT_DEV_PATH}/.gitmodules"; then
			submodule="[submodule \"${theme}\"]
	\tpath = app/content/themes/${theme}
	\turl = git://github.com/${WP_THEMES_TO_INSTALL_GITHUB[${theme}]}/${theme}"
		 	echo -e "${submodule}" >> "${PROJECT_DEV_PATH}/.gitmodules"
		fi
	done

	# Activate theme.
	if [[ $WP_THEME_TO_ACTIVATE != '' ]]; then
		wp theme activate "${WP_THEME_TO_ACTIVATE}" --allow-root
	fi

	# Use a custom post-setup file for themes if we have one.
	if [[ -f "${this_dir}/vvv-init-setup-themes-post.sh" ]]; then
		bash "${this_dir}/vvv-init-setup-themes-post.sh"
	fi

fi
