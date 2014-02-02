#!/bin/bash
#
# init-custom-sql.sh
#
# Automatically customizes your init-custom.sql file, so you don't have to
# create your database manually.

# Include config file.
this_dir=`readlink -f $(dirname $0)`
. "${this_dir}/config.sh"

# If init-custom.sql does not exist, create it from init-custom.sql.example.
if [[ ! -f /vagrant/database/init-custom.sql ]]; then
	sudo cp /vagrant/database/init-custom.sql.sample /vagrant/database/init-custom.sql
fi

# If "my_database_name" is found into init-custom.sql, just replace all the
# default values with the ones obtained from config file. Otherwise, just add 
# our custom sql commands to the end of the file. This last thing is specially
# useful when you have more than one website project into your VVV machine.
echo -e "\nWriting custom sql commands into /vagrant/database/init-custom.sql"
if grep -q "my_database_name" /vagrant/database/init-custom.sql; then
    # Store values to be replaced.
    declare -A replacements
    replacements=( ["my_database_name"]="${WP_DB_NAME}" ["thisuser"]="${WP_DB_USER}" ["thatpass"]="${WP_DB_PASSWORD}" )
    # Perform replacements.
    for index in ${!replacements[*]}; do
        sed -i "s/${index}/${replacements[$index]}/g" /vagrant/database/init-custom.sql
    done
    echo " * Custom sql commands were succesfully added."
else
	# If our DB name already exists into init-custom.sql, the we do nothing.
    if grep -q "$DB_NAME" /vagrant/database/init-custom.sql; then
    	echo " * /vagrant/database/init-custom.sql was already set up."
    # If our DB name does not exist into init-custom.sql, then we add our
    # custom sql commands to the end of the file.
    else
    	echo "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;" >> /vagrant/database/init-custom.sql
    	echo "GRANT ALL PRIVILEGES ON \`${WP_DB_NAME}\`.* TO '${WP_DB_USER}'@'localhost' IDENTIFIED BY '${WP_DB_PASSWORD}';" >> /vagrant/database/init-custom.sql
    	echo " * Custom sql commands were succesfully added."
    fi
fi
