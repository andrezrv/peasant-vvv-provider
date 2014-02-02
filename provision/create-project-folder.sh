#!/bin/bash
#
# create-project-folder.sh
#
# Automatically creates your project folder.

# Include config file.
this_dir=`readlink -f $(dirname $0)`
. "${this_dir}/config.sh"

# Check if folder exists. If it does not, attempt to create it recursively.
# Otherwise, do nothing.
echo -e "\nChecking if project folder exists..."
if [ ! -d "${PROJECT_PATH}" ]; then
	echo " * Creating project folder..."
	mkdir -p "${PROJECT_PATH}"
	if [ -d "${PROJECT_PATH}" ]; then
		echo " * Project folder created succesfully in ${PROJECT_PATH}."
	else
		echo " * Project folder could not be created."
	fi
else 
	echo " * Project folder already exists in ${PROJECT_PATH}."
fi
