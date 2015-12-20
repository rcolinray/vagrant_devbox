QUAY_USERNAME = ENV['QUAY_USERNAME']
QUAY_PASSWORD = ENV['QUAY_PASSWORD']
QUAY_EMAIL = ENV['QUAY_EMAIL']

if QUAY_USERNAME.nil? or QUAY_PASSWORD.nil? or QUAY_EMAIL.nil?
	puts "WARNING: Could not find credentials for quay.io."
end

Vagrant.configure("2") do |config|
	# General config
	config.vm.hostname = "taccs-dev"
	config.vm.network "public_network"

	# Virtualbox config
	config.vm.provider "virtualbox" do |provider|
		config.vm.box = "boxcutter/centos71"

		provider.name = "taccs-dev"

		provider.memory = 8192
		provider.cpus = 2
	end

	# SSH config
	config.ssh.forward_agent = true

	# Install tools
	config.vm.provision "tools", type: "shell" do |shell|
		shell.inline = "yum install -y git"
	end

	# Set up TACCS dev environment
	config.vm.provision "taccs", type: "shell" do |shell|
		shell.inline = <<-SHELL
			mkdir -p ~/.ssh
			chmod 700 ~/.ssh
			ssh-keyscan -H github.com >> ~/.ssh/known_hosts
			ssh -T git@github.com
			if ! [ -d taccs ]; then
				git clone git@github.com:priority5/taccs.git
			fi
			cd /home/vagrant/taccs

			sudo taccs/tools/taccs_ctl/taccs_ctl.py bootstrap --no-admin-user
			docker login -u #{QUAY_USERNAME} -p #{QUAY_PASSWORD} -e #{QUAY_EMAIL} quay.io

			cd /home/vagrant/taccs/ci_config
			cp /vagrant/local_dev_settings.py ./
			sudo ./start_local_dev_env.py
		SHELL
	end
end