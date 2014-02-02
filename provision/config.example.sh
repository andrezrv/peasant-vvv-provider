#!/bin/bash
#
# config.cfg
#
# The custom auto-provisioner will configure your settings here. Please keep in
# mind that this file is not meant to be modified manually, but only by the
# Provision file in the main folder of this library.

# General settings
PROJECT_ID="%%PROJECT_ID%%"
PROJECT_PATH="%%PROJECT_PATH%%"
PROJECT_HOSTS=%%PROJECT_HOSTS%%

# WordPress blog settings
WP_PROVIDER="%%WP_PROVIDER%%" # 'wordpress-bareboner' or your repo URL
WP_PROJECT_NAME="%%WP_PROJECT_NAME%%"
WP_DOMAIN_NAME="%%WP_DOMAIN_NAME%%"
WP_ADMIN_NAME="%%WP_ADMIN_NAME%%"
WP_ADMIN_PASSWORD="%%WP_ADMIN_PASSWORD%%"
WP_ADMIN_EMAIL="%%WP_ADMIN_EMAIL%%"
WPCOM_API_KEY="%%WPCOM_API_KEY%%"

# WordPress database settings
WP_DB_USER="%%WP_DB_USER%%" # User name for the local database
WP_DB_PASSWORD="%%WP_DB_PASSWORD%%" # Password for the database
WP_DB_NAME="%%WP_DB_NAME%%" # Database name
WP_DB_HOST="%%WP_DB_HOST%%" # Database host, usually 'localhost'
WP_TABLE_PREFIX="%%WP_TABLE_PREFIX%%" # Tables prefix
WP_DB_BACKUP_PATH="%%WP_DB_BACKUP_PATH%%" # Full path to the folder where the database backups will be kept
WP_DB_MAX_BACKUPS="%%WP_DB_MAX_BACKUPS%%" # Maximum number of database backups to keep

# WordPress themes settings
WP_THEMES_TO_INSTALL=%%WP_THEMES_TO_INSTALL%%
declare -A WP_THEMES_TO_INSTALL_GITHUB=%%WP_THEMES_TO_INSTALL_GITHUB%%
WP_THEME_TO_ACTIVATE="%%WP_THEME_TO_ACTIVATE%%"

# WordPress plugins settings
WP_PLUGINS_TO_INSTALL=%%WP_PLUGINS_TO_INSTALL%%
declare -A WP_PLUGINS_TO_INSTALL_GITHUB=%%WP_PLUGINS_TO_INSTALL_GITHUB%%
WP_PLUGINS_TO_ACTIVATE=%%WP_PLUGINS_TO_ACTIVATE%%

# Git settings
GIT_REMOTE_REPO="%%GIT_REMOTE_REPO%%"
GIT_USERNAME="%%GIT_USERNAME%%"
GIT_USEREMAIL="%%GIT_USEREMAIL%%"

# Deploy settings
DEPLOY_USER="%%DEPLOY_USER%%"
PRODUCTION_DOMAIN="%%PRODUCTION_DOMAIN%%"
STAGING_DOMAIN="%%STAGING_DOMAIN%%"
STAGE_WP_CDN_DOMAIN="%%STAGE_WP_CDN_DOMAIN%%"

# Production database settings
PRODUCTION_DB_USER="%%PRODUCTION_DB_USER%%" # User name for the local database
PRODUCTION_DB_PASSWORD="%%PRODUCTION_DB_PASSWORD%%" # Password for the database
PRODUCTION_DB_NAME="%%PRODUCTION_DB_NAME%%" # Database name
PRODUCTION_DB_HOST="%%PRODUCTION_DB_HOST%%" # Database host
PRODUCTION_DB_BACKUP_PATH="%%PRODUCTION_DB_BACKUP_PATH%%" # Path to the folder where the database backups will be kept

# Staging database settings
STAGING_DB_USER="%%STAGING_DB_USER%%" # User name for the local database
STAGING_DB_PASSWORD="%%STAGING_DB_USER%%" # Password for the database
STAGING_DB_NAME="%%STAGING_DB_NAME%%" # Database name
STAGING_DB_HOST="%%STAGING_DB_HOST%%" # Database host
STAGING_DB_BACKUP_PATH="%%STAGING_DB_BACKUP_PATH%%" # Path to the folder where the database backups will be kept

# Application settings
APPLICATION_BACKUP_PATH="%%APPLICATION_BACKUP_PATH%%" # Path to the folder where the application backup will be kept
APPLICATION_MAX_BACKUPS="%%APPLICATION_MAX_BACKUPS%%" # Maximum number of application backups to keep

# Load settings
this_dir="$(dirname `realpath $0`)"
. "${this_dir}/settings.sh"
