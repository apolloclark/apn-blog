# packer-aws-webapp-config

Packer based project for provisioning a "webapp" image using Ansible remote, 
and Serverspc, for AWS, or Virtualbox, with Elastic monitoring.

## Requirements

To use this project, you must have installed:
- [Packer](https://www.packer.io/downloads.html)
- [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
- [Serverspec](http://serverspec.org/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- [jq](https://stedolan.github.io/jq/)

(Optional)
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)

## Deploy to AWS, with Packer
```shell
git clone https://github.com/apolloclark/packer-aws-webapp
cd ./packer-aws-webapp/config
# create a keypair named "packer" or change lines 26, 27 in build_packer_aws.sh
./build_packer.sh
```

## Deploy Locally, with Vagrant
```shell
git clone https://github.com/apolloclark/packer-aws-webapp
cd ./packer-aws-webapp/config
# change line 6 in build_packer_virtualbox.sh to a folder with an Ubuntu 16.04 ISO
vagrant up
vagrant ssh
# http://127.0.0.1:8080
```

## MySQL
```shell
mysql -h 127.0.0.1 -u root -p
```

## Ansible

Ansible Roles:
- [geerlingguy.firewall](https://github.com/geerlingguy/ansible-role-firewall)
- geerlingguy.apache
- apolloclark.apache-modsecurity
- apolloclark.mysql
- apolloclark.mysql-mcafee-audit
- apolloclark.mysql-deploy
- geerlingguy.php-versions
- geerlingguy.php
- geerlingguy.apache-php-fpm
- geerlingguy.php-mysql
- geerlingguy.composer
