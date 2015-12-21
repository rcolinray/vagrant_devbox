Vagrant.configure("2") do |config|
	# Hostmanager config
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true

	# General config
	config.vm.hostname = "taccs-dev"
	config.vm.network "private_network", ip: "192.168.0.0"

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
	config.vm.provision "install tools", type: "shell" do |shell|
		shell.inline = "yum install -y git vim"
	end

	# Set up TACCS dev environment
	config.vm.provision "set up", type: "shell" do |shell|
		shell.privileged = false
		shell.inline = <<-SHELL
			cp /vagrant/vimrc ~/.vimrc

			git config --global user.name = "Colin Ray"
			git config --global user.email = "r.colinray@gmail.com"
		SHELL
	end

	# Start TACCS containers
	config.vm.provision "start docker", type: "shell", run: "always" do |shell|
		shell.inline = <<-SHELL
			docker &>/dev/null
			if [ $? -eq 0 ]; then
				docker start taccs_db redis ejabberd unity_sm elasticsearch logstash kibana haproxy
			fi
		SHELL
	end
end