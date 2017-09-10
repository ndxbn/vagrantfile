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
=begin
@startuml
title package installation dependency map

package pre_install {
  package upgrade {
    package curl
    package git
    package wget
  }
}
package disable_bashrc {
  package root
  package ubuntu
}
package install {
  package apt {
      package gcc
      package jq
      package make
      package stow
  }

  package hub

  package anyenv {
    package goenv
    package nodeenv
    package phpenv
    package rbenv
  }

  package dotfiles
}

upgrade <-- apt

jq <-- hub
curl <-- hub
wget <-- hub

git <-- anyenv

git <-- dotfiles
stow <-- dotfiles

@enduml
=end

  ## pre-install
  config.vm.provision 'shell', inline: 'apt-get -y upgrade'

  ## install
  ### system wide
  config.vm.provision 'shell', path: './provisioning/apt-get--install.sh'
  config.vm.provision 'shell', path: './provisioning/install_hub.sh'
  ### user local'
  config.vm.provision 'shell', path: './provisioning/install_anyenv.sh',
                      privileged: false
  ### optionals
  config.vm.provision 'shell', path: './provisioning/install_libs--php.sh'
  config.vm.provision 'shell', path: './provisioning/install_libs--ruby.sh'

  ## file deployment
  config.vm.provision 'shell', path: './provisioning/disable_bashrc--root-user.sh'
  config.vm.provision 'shell', path: './provisioning/disable_bashrc--ubuntu-user.sh'

  # configuration test
  config.vm.provision 'shell', path: './spec/test_command_exists.sh'
end
