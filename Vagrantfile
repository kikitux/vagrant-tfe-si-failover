# -*- mode: ruby -*-
# vi: set ft=ruby :
#

puts "warn: you need license.rli file" if !File.exist?("license.rli")

Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/bionic64"
    config.vm.network "private_network", type: "dhcp"
      
    config.vm.synced_folder "cache", "/var/cache/apt/archives/", create: true, owner: "_apt", group: "root", mount_options: ["dmode=777,fmode=666"]

    # user variable
    release = 0

    # https://developer.hashicorp.com/terraform/enterprise/releases
    # latest 0
    #
    # v202211-1	660
    # v202210-1	659
    # v202209-2	655
    # v202209-1	654

    # internal variables
    give_info = true
    port = 2
    disk = "tfe"

    config.vm.define "vm1" , autostart: true do |vm1|
        vm1.vm.hostname = "tfe1"

        vm1.vm.provider "virtualbox" do |v|     
            v.memory = 1024 * 4
            v.cpus = 2
            localdisk="#{disk}1"
            if !File.exist?("#{localdisk}.vdi")
                unless give_info==false
                    puts "info: on first boot disk will be created"
                    give_info=false
                end
                v.customize ['createhd', '--filename', "#{localdisk}.vdi", '--size', (50 * 1024).floor]
            end
            v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', port, '--device', 0, '--type', 'hdd', '--medium', "#{localdisk}.vdi"]
        end

        vm1.vm.provision "shell", path: "scripts/config_mount_disk.sh", run: "always"
        vm1.vm.provision "shell", path: "scripts/install_tools.sh"
        vm1.vm.provision "shell", path: "scripts/install_terraform.sh"
        vm1.vm.provision "shell", path: "scripts/download_uninstall.sh"
        vm1.vm.provision "shell", path: "scripts/config_replicated.sh", env: { "RELEASE" => release||=String.new }
        vm1.vm.provision "shell", path: "scripts/run_docker_load.sh" # we install docker, and load previous downloaded images
        vm1.vm.provision "shell", path: "scripts/install_tfe.sh"
        vm1.vm.provision "shell", path: "scripts/run_docker_save.sh" # we save downloaded images
        vm1.vm.provision "shell", path: "scripts/run_replicated_db_backup.sh"
        vm1.vm.provision "shell", path: "scripts/initial_user_tfe.sh"
    end

    config.vm.define "vm2" , autostart: false do |vm2|
        vm2.vm.hostname = "tfe2"

        vm2.vm.provider "virtualbox" do |v|     
            v.memory = 1024 * 4
            v.cpus = 2
            remotedisk="#{disk}1"
            localdisk="#{disk}2"
            if !File.exist?("#{localdisk}.vdi")
                unless give_info==false
                    puts "info: on first boot disk will be created"
                    give_info=false
                end
                v.customize ['clonemedium', "#{remotedisk}.vdi", "#{localdisk}.vdi"]
            end
            v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', port, '--device', 0, '--type', 'hdd', '--medium', "#{localdisk}.vdi"]
        end

        vm2.vm.provision "shell", path: "scripts/config_mount_disk.sh", run: "always"
        vm2.vm.provision "shell", path: "scripts/install_tools.sh"
        vm2.vm.provision "shell", path: "scripts/install_terraform.sh"
        vm2.vm.provision "shell", path: "scripts/download_uninstall.sh"
        vm2.vm.provision "shell", path: "scripts/config_replicated.sh", env: { "RELEASE" => release||=String.new }
        vm2.vm.provision "shell", path: "scripts/run_docker_load.sh" # we install docker, and load previous downloaded images
        vm2.vm.provision "shell", path: "scripts/install_tfe.sh"
    end

end
