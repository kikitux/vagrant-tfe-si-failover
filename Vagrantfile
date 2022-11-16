# -*- mode: ruby -*-
# vi: set ft=ruby :
#

puts "warn: you need license.rli file" if !File.exist?("license.rli")

Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/bionic64"
    config.vm.network "private_network", type: "dhcp"
      
    #variables
    give_info=true
    port=2
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
        vm1.vm.provision "shell", path: "scripts/config_replicated.sh"
        vm1.vm.provision "shell", path: "scripts/install_tfe.sh"
        vm1.vm.provision "shell", path: "scripts/run_replicated_db_backup.sh"
        vm1.vm.provision "shell", path: "scripts/initial_user_tfe.sh"
    end

    config.vm.define "vm2" , autostart: false do |vm2|
        vm2.vm.hostname = "tfe1"

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
        vm2.vm.provision "shell", path: "scripts/config_replicated.sh"
        vm2.vm.provision "shell", path: "scripts/install_tfe.sh"
    end

end
