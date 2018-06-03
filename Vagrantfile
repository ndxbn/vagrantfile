# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = 'ndxbn.local'

  # Network
  # https://www.vagrantup.com/docs/networking/
  config.vm.network :private_network, ip: "192.168.56.17"

  # Provisioning
  # https://www.vagrantup.com/docs/provisioning/
  ## My dotfiles pre-install script
  ## see https://github.com/ndxbn/dotfiles
  config.vm.provision :shell, path: 'https://raw.githubusercontent.com/ndxbn/dotfiles/master/centos.sh'
end
