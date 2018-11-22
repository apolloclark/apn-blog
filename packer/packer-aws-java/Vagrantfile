# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    # Ubuntu 16.04 Xenial LTS 64-bit
    config.vm.box = "apolloclark/ubuntu16.04"
    # config.vm.box_version = "20170926"

    # VirtualBox Provider-specific configuration
    config.vm.provider "virtualbox" do |vb, override|

        # set the VM name
        vb.name = "packer-aws-java"

        # set the CPU, memory, graphics
        # @see https://www.virtualbox.org/manual/ch08.html
        vb.cpus = 1
        vb.memory = "2048"
        vb.gui = false

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
end
