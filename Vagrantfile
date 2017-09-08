Vagrant.configure("2") do |config|
  # bootstrapping
  config.vm.box = "ubuntu/xenial64"
  config.vm.network :private_network, ip: "192.168.56.17"
  ## synced folder
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./synced_folder", "/vagrant", type: "rsync"

  # configuration
  ## install docker
  config.vm.provision :docker do |docker|
    # maybe minimal image
    docker.pull_images "alpine"
  end

  ## via apt
  config.vm.provision 'shell', inline: 'apt-get -y upgrade'
  config.vm.provision 'shell', path: './provisioning/apt-get--install.sh'
  config.vm.provision 'shell', path: './provisioning/disable_bashrc--root-user.sh'
  config.vm.provision 'shell', path: './provisioning/disable_bashrc--ubuntu-user.sh'

  # configuration test
  config.vm.provision 'shell', path: './spec/command_exists.sh'
end
