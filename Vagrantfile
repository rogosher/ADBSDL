$init_script = <<SCRIPT
apt-get update
apt-get upgrade
apt-get build-dep arduino-mk
apt-get install arduino-core build-essential dpkg-dev fakeroot devscripts
apt-get install -y arduino-mk python-serial arduino-core

SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder "./", "/opt/Arduboy/"
  config.vm.provision :shell, inline: $init_script
end
