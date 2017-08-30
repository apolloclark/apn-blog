# aws-terraform

Terraform project for deploying a webservice including:
- Amazon AWS
- VPC (Virtual Private Cloud)
- SSH Bastion Host, with EIP (Elastic IP)
- Private-network only SSH Bastion access
- RDS (Relational Database Service)
- ELB (Elastic Load Balancer)
- Auto-scaling Groups
- Cloudwatch Metric Alarms
- Auto-scaling Policy Triggers

# Before You Begin
If you haven't already configured the AWS CLI, or another SDK, on the machine
where you will be running Terraform you should follow these instructions to
setup the AWS CLI and create a credential profile which Terraform will use for
authentication:  
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

# Launching
```shell
git clone https://github.com/apolloclark/aws-terraform/
cd aws-terraform/terraform_demo
terraform get
terraform plan
terraform apply
```