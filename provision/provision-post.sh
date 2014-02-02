#!/bin/bash
#
# provision-post.sh
#
# This file will run all specified post-provisions for a VVV environment.

# Include config file.
this_dir=`readlink -f $(dirname $0)`
. "${this_dir}/config.sh"

echo -e "\nRunning ${this_dir}/provision-post.sh..."
if [[ ! -f "${this_dir}/../Lockfile" ]]; then
	# Install Capistrano
	bash "${this_dir}/install-capistrano.sh"
else
	echo -e "\nPost-provision skipped due to existance of Lockfile\n"
fi