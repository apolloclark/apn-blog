# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    # Ubuntu 16.04 Xenial LTS 64-bit, Elastic
    config.vm.box = "apolloclark/ubuntu16.04-elk"

    # VirtualBox Provider-specific configuration
    config.vm.provider "virtualbox" do |vb, override|

        # set the VM name
        vb.name = "packer-aws-bastion-config"

        # set the CPU, memory, graphics
        # @see https://www.virtualbox.org/manual/ch08.html
        vb.cpus = 1
        vb.memory = "4096"
        vb.gui = false

        # Create a forwarded port mapping which allows access to a specific port
        # within the machine from a port on the host machine. In the example below,
        # accessing "localhost:8080" will access port 80 on the guest machine.
        # https://www.vagrantup.com/docs/networking/forwarded_ports.html
        override.vm.network "forwarded_port", guest: 2181, host: 2181, auto_correct: true
        override.vm.network "forwarded_port", guest: 5044, host: 5044, auto_correct: true
        override.vm.network "forwarded_port", guest: 5601, host: 5601, auto_correct: true
        override.vm.network "forwarded_port", guest: 9092, host: 9092, auto_correct: true
        override.vm.network "forwarded_port", guest: 9200, host: 9200, auto_correct: true
        override.vm.network "forwarded_port", guest: 9300, host: 9300, auto_correct: true

        # setup local apt-get cache
        if Vagrant.has_plugin?("vagrant-cachier")
            # Configure cached packages to be shared between instances of the same base box.
            # https://github.com/fgrehm/vagrant-cachier
            # More info on the "Usage" link above
            override.cache.scope = :box
        end
    end
end
