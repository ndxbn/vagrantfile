require 'yaml'
require 'pathname'

# path settings
current_dir = Pathname(File.expand_path(File.dirname(__FILE__)))
## config files
conf_dir = current_dir
homestead_yaml_path = conf_dir / "Homestead.yaml"

Vagrant.configure("2") do |config|
  unless File.exist? homestead_yaml_path
    abort "Homestead settings file not found"
  end
  settings = YAML::load(homestead_yaml_path.read)

  config.ssh.forward_agent = true

  # names
  config.vm.box = settings["box"] || "laravel/homestead"

  # machine spec
  config.vm.provider "virtualbox" do |vb|
    # vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
    # vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
    vb.cpus = settings["cpus"] || 1
    vb.memory = settings["memory"] || 2048
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", settings["natdnshostresolver"] ||= "on"]
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
  end

  # network
  config.vm.hostname = settings["hostname"]
  config.vm.network :private_network, ip: settings["ip"]
  ## port
  settings["ports"].each do |port|
    config.vm.network "forwarded_port", guest: port["guest"], host: port["host"], protocol: port["protocol"], auto_correct: true
  end

  # synced folder
  if settings.include? 'folders'
    settings["folders"].each do |folder|
      if File.exists? File.expand_path(folder["map"])
        mount_opts = []

        if folder["type"] == "nfs"
          mount_opts = folder["mount_options"] ? folder["mount_options"] : ['actimeo=1', 'nolock']
        elsif folder["type"] == "smb"
          mount_opts = folder["mount_options"] ? folder["mount_options"] : ['vers=3.02', 'mfsymlinks']
        end

        # For b/w compatibility keep separate 'mount_opts', but merge with options
        options = (folder["options"] || {}).merge({mount_options: mount_opts})

        # Double-splat (**) operator only works with symbol keys, so convert
        options.keys.each {|k| options[k.to_sym] = options.delete(k)}

        config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil, **options
      end
    end
  end

  # nginx
  config.vm.provision "shell", path: "./scripts/clear-nginx.sh"
  ## configuration
  settings["sites"].each do |site|
    config.vm.provision "shell",
                        name: "create certiicate" + site["name"],
                        path: "./scripts/create-certificate.sh",
                        args: [site["name"]]
    config.vm.provision "shell",
                        name: "create site" + site["name"],
                        path: "./scripts/serve-laravel.sh",
                        args: [site["name"], site["to"], site["port"], site["ssl"], site["php"]]
  end
  ## restart
  config.vm.provision "shell",
                      inline: "systemctl restart nginx php5.6-fpm php7.0-fpm php7.1-fpm php7.2-fpm"

  # Elastic Search
  config.vm.provision "shell", path: "./scripts/install-elasticsearch.sh"

  # databases
  ## apply configuration to each database
  settings["databases"].each do |db|
    config.vm.provision "shell",
                        name: "Creating MySQL Database: " + db,
                        path: "./scripts/create-mysql.sh",
                        args: [db]
    config.vm.provision "shell",
                        name: "Creating Postgres Database: " + db,
                        path: "./scripts/create-postgres.sh",
                        args: [db]
  end

  # composer self-update
  config.vm.provision "shell",
                      name: "Update Composer",
                      inline: "/usr/local/bin/composer self-update && chown -R vagrant:vagrant /home/vagrant/.composer/"


  # install by root
  # jq
  config.vm.provision "shell", path: "./scripts/install-jq.sh"
  # stow
  config.vm.provision "shell", path: "./scripts/install-stow.sh"
  # zsh
  config.vm.provision "shell", path: "./scripts/install-zsh.sh"

  # install to vagrant user
  # hub command
  config.vm.provision "shell", path: "./scripts/install-hub.sh", privileged: false

  # after
  config.vm.provision "shell", path: "./scripts/after--sudo.sh"
  config.vm.provision "shell", path: "./scripts/after.sh", privileged: false

  # tests
  config.vm.provision "shell", path: "./tests/test_command_exists.sh"
end
