# packer-aws-java

Packer based project for provisioning a "java" image using Ansible remote, 
and Serverspc, for AWS, or Virtualbox, with Elastic monitoring and Java.

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
git clone https://github.com/apolloclark/packer-aws-java
cd packer-aws-java
# create a keypair named "packer" or change lines 26, 27 in build_packer_aws.sh
./build_packer.sh
```

## Deploy Locally, with Vagrant
```shell
git clone https://github.com/apolloclark/packer-aws-java
cd packer-aws-java
vagrant up
vagrant ssh
```

## Ansible

Ansible Roles:
- [geerlingguy.java](https://github.com/geerlingguy/ansible-role-java)
