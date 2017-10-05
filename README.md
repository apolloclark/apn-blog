# aws-terraform

Terraform project for deploying a webservice including:
- Amazon AWS
- VPC (Virtual Private Cloud)
- SSH Bastion Host, with EIP (Elastic IP)
- Private-network only SSH Bastion access
- RDS (Relational Database Service)
- ALB (Application Load Balancer)
- Auto-scaling Groups
- Cloudwatch Metric Alarms
- Auto-scaling Policy Triggers

To Do:
- ELK cluster
- S3 bucket for log collection
- IAM role for accessing S3 logs bucket
- S3 bucket for file hosting
- ElasticCache for Redis
- AWS WAF (Web Application Firewall)
- Lamda rules for dynamic WAF rules
- SES (Simple Email Service) for alerts
- Gitlab
- Jenkins
- Packer
- Varnish Cache HTTP cache

![AWS Network Diagram](https://github.com/apolloclark/aws-terraform/blob/master/aws_e2e_web.jpg)

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
terraform show
```