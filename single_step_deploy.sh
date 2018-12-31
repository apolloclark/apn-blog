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



# check if the "packer" keypair exists
if ! aws ec2 describe-key-pairs --output=text | grep 'packer'; then

	echo "Creating packer keypair...";

	# create an EC2 keypair named "packer"
	aws ec2 create-key-pair --key-name packer --query "KeyMaterial" \
	   --output text > ~/.ssh/packer.pem

	# configure key file permissions
	chmod 0600 ~/.ssh/packer.pem

	# add the newly created key to the keychain
	ssh-add ~/.ssh/packer.pem
fi


# clone the project, and sub-modules
git submodule update --recursive --remote
cd ./aws-ec2

# use Packer to build the AWS AMI's
./build_packer_aws.sh

# deploy AWS infrastructure with Terraform
terraform init
./build_terraform.sh
