# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ndxbn/grim"

  # network
  config.vm.network :private_network, ip: "192.168.56.17"

  ## synced folder
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./code", "/home/vagrant/code", type: "rsync"

end
