# vagrant_devbox

Scripts to set up a virtual machine for TACCS development.

## Usage

When setting up the virtual machine for the first time, run the following commands to start the virtual machine and initialize the TACCS development environment:

```bash
vagrant up
eval $(ssh-agent -s)
ssh-add path/to/github/private/key
vagrant ssh
/vagrant/init.sh
```

Once the virtual machine is set up, running `vagrant up` will start the virtual machine and the docker containers.
