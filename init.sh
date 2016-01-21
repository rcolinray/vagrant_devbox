#!/usr/bin/bash

# Checkout TACCS source
if ! [-d taccs ]; then
	git clone git@github.com:priority5/taccs.git
fi
cd taccs

# Install Docker
docker &>/dev/null
if ! [ $? -eq 0 ]; then
	sudo ./taccs/tools/taccs_ctl/taccs_ctl.py bootstrap --no-admin-user
	echo "Please enter your quay.io credentials."
	read -p "Username: " quay_user
	read -s -p "Password: " quay_pass
	read -p "Email: " quay_email
	sudo docker login -u $quay_user -p $quay_pass -e $quay_email quay.io
fi

# Start containers
cd ci_config
cp /vagrant/local_dev_settings.py ./
sudo ./start_local_dev_env.py
