# tf-aws

## Before You Begin
If you haven't already configured the AWS CLI, or another SDK, on the machine
where you will be running Terraform you should follow these instructions to
setup the AWS CLI and create a credential profile which Terraform will use for
authentication:  
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

## Deploy
```shell
git clone https://github.com/apolloclark/tf-aws/
cd tf-aws/terraform_demo
terraform get
terraform plan
terraform apply
terraform show
```

## Overview
Terraform project for deploying a multi-tier webservice including:
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

## Network Diagram

![AWS Network Diagram](https://github.com/apolloclark/aws-terraform/blob/master/aws_e2e_web.jpg)

## VM Images, Ansible Roles

**[packer-aws-base](https://github.com/apolloclark/packer-aws-base)**
- [osquery](https://github.com/apolloclark/ansible-role-osquery)
- [filebeat](https://github.com/apolloclark/ansible-role-filebeat)
- [metricbeat](https://github.com/apolloclark/ansible-role-metricbeat)
- [heartbeat](https://github.com/apolloclark/ansible-role-heartbeat)
- [packetbeat](https://github.com/apolloclark/ansible-role-packetbeat)
- [firewall](https://github.com/geerlingguy/ansible-role-firewall)
- [ntp](https://github.com/geerlingguy/ansible-role-ntp)
- [git](https://github.com/geerlingguy/ansible-role-git)

&nbsp;&nbsp;&nbsp;&nbsp;**packer-aws-webapp**
  - [apache](https://github.com/geerlingguy/ansible-role-apache)
  - [apache-modsecurity](https://github.com/apolloclark/ansible-role-apache-modsecurity)
  - [php](https://github.com/geerlingguy/ansible-role-php)
  - [php-fpm](https://github.com/geerlingguy/ansible-role-apache-php-fpm)
  - [mysql](https://github.com/apolloclark/ansible-role-mysql)

&nbsp;&nbsp;&nbsp;&nbsp;**packer-aws-java**
  - java

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**packer-aws-elk**
    - [Elasticsearch](https://github.com/apolloclark/ansible-role-elasticsearch)
    - Logstash
    - [Kibana](https://github.com/apolloclark/ansible-role-kibana)
    - Beats Dashboards
    - X-Pack
