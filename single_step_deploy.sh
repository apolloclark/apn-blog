#!/bin/bash -eux

# single-step deploy script, just to prove that it's possible ;)



# check if aws-cli is installed
if ! [ -x "$(command -v aws)" ]; then
	echo "[ERROR] aws-cli is not installed: https://docs.aws.amazon.com/cli/latest/userguide/installing.html"
	exit 1;
fi

# check if packer is installed
if ! [ -x "$(command -v packer)" ]; then
	echo "[ERROR] packer is not installed: https://www.packer.io/downloads.html"
	exit 1;
fi

# check if ansible is installed
if ! [ -x "$(command -v ansible)" ]; then
	echo "[ERROR] ansible is not installed: https://docs.ansible.com/ansible/2.3/intro_installation.html"
	exit 1;
fi

# check if serverspec is installed
if ! [ -x "$(command -v rake)" ]; then
	echo "[ERROR] serverspec is not installed: https://serverspec.org/"
	exit 1;
fi

# check if terraform is installed
if ! [ -x "$(command -v terraform)" ]; then
	echo "[ERROR] terraform is not installed: https://www.terraform.io/downloads.html"
	exit 1;
fi



# create an EC2 keypair named "packer"
aws ec2 create-key-pair --key-name packet --query "KeyMaterial" \
   --output text > ~/.ssh/packer.pem

# configure key file permissions
chmod 0600 ~/.ssh/packer.pem

# add the newly created key to the keychain
ssh-add ~/.ssh/packer.pem



# clone the project, and sub-modules
git clone --recurse-submodules https://github.com/apolloclark/tf-aws
cd tf-aws

# use Packer to build the AWS AMI's
./build_packer_aws.sh

# deploy AWS infrastructure with Terraform
./build_terraform.sh
