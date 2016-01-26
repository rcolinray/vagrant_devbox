#!/usr/bin/bash

# This script performs set up routines that are tricky to do through a Vagrant provisioner. 
# SSH forwarding does not work as one would expect when provisioning, and there is currently
# no support for prompting the user for input (e.g., for credentials).

# Checkout TACCS source
if ! [ -d taccs ]; then
	git clone git@github.com:priority5/taccs.git
fi
cd taccs

# Install Docker
docker &>/dev/null
if ! [ $? -eq 0 ]; then
	sudo ./taccs/tools/taccs_ctl/taccs_ctl.py bootstrap --no-admin-user
	sudo docker login quay.io
fi

# Start containers
cd ci_config
cp /vagrant/local_dev_settings.py ./
sudo ./start_local_dev_env.py
