# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    # Ubuntu 16.04 Xenial LTS 64-bit
    config.vm.box = "apolloclark/ubuntu16.04"

    # VirtualBox Provider-specific configuration
    config.vm.provider "virtualbox" do |vb, override|

        # set the VM name
        vb.name = "ubuntu16.04-beats"

        # set the CPU, memory, graphics
        # @see https://www.virtualbox.org/manual/ch08.html
        vb.cpus = 1
        vb.memory = "1024"
        vb.gui = false

        # Share a folder to the guest VM, types: docker, nfs, rsync, smb, virtualbox
        # Windows supports: smb
        # Mac supports: rsync, nfs
        # override.vm.synced_folder host_folder.to_s, guest_folder.to_s, type: "smb"
        # override.vm.synced_folder "./ansible", "/vagrant"

        # setup local apt-get cache
        if Vagrant.has_plugin?("vagrant-cachier")
            # Configure cached packages to be shared between instances of the same base box.
            # https://github.com/fgrehm/vagrant-cachier
            # More info on the "Usage" link above
            override.cache.scope = :box
        end
    end
      
    # Configure the box with Ansible, running within the Guest Machine
    # https://www.vagrantup.com/docs/provisioning/ansible.html
    # https://www.vagrantup.com/docs/provisioning/ansible_common.html
    config.vm.provision "ansible" do |ansible|
        ansible.galaxy_role_file = "./ansible/requirements.yml"
        ansible.playbook = "./ansible/playbook.yml"
    end

    # Verify the components are installed and running
    # https://github.com/vvchik/vagrant-serverspec
    # This plugin uses it's own custom Rakefile, but will reuse any existing
    # local spec_helper.rb script
    config.vm.provision "serverspec" do |spec|
      
        # pattern for specfiles to search
        spec.pattern = 'spec/*/*_spec.rb'
    end
end
