# Vagrantfile
#
# Arduboy, 2016.
#
# Vagrantfile defining the virtual-machine for the Arduboy cross-platform
# compiler.

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder "./", "/opt/Arduboy/"
  config.vm.provision :shell, path: "scripts/provision_vagrant.sh"
end
