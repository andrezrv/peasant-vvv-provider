#!/bin/bash
#
# settings.sh
#
# This file manages application variables that should not be set manually.

# Application settings
PROJECT_DEV_PATH="${PROJECT_PATH}/dev" # Path to your application's development release
APPLICATION_PATH="${PROJECT_DEV_PATH}/app" # Path to the folder were all the application files will be kept
APPLICATION_SHARED_FOLDER="${APPLICATION_PATH}/shared" # Path to files shared between releases 
APPLICATION_WORDPRESS_PATH="${PROJECT_DEV_PATH}/wordpress" # Path to your application's website
APPLICATION_LIVE_PATH="${PROJECT_DEV_PATH}/live" # Symlinked path to your application's website
APPLICATION_MAINTENANCE_PATH="${PROJECT_DEV_PATH}/background" # Symlinked path to your application's maintenance version
APPLICATION_TRANSITIONAL_PATH="${PROJECT_DEV_PATH}/transition" # Symlinked path to a transitional filename for maintenance
