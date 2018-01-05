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



## Network Diagram

![AWS Network Diagram](https://github.com/apolloclark/aws-terraform/blob/master/aws_e2e_web.jpg)

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
- CloudTrail Logs
- VPC Flow Logs
- AWS WAF (Web Application Firewall)
- Lamda rules for dynamic WAF rules
- Guard Duty
---
- SES (Simple Email Service) for alerts
- S3 bucket for file hosting
- ElasticCache for Redis
- Jenkins
- Packer
- JMeter
- Gitlab
- HAProxy
- ProxySQL
- Varnish Cache HTTP cache



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

- **packer-aws-webapp**
  - [apache](https://github.com/geerlingguy/ansible-role-apache)
  - [apache-modsecurity](https://github.com/apolloclark/ansible-role-apache-modsecurity)
  - [php](https://github.com/geerlingguy/ansible-role-php)
  - [php-fpm](https://github.com/geerlingguy/ansible-role-apache-php-fpm)
  - [mysql](https://github.com/apolloclark/ansible-role-mysql)

- **packer-aws-java**
  - java

  - **packer-aws-elk**
    - [Elasticsearch](https://github.com/apolloclark/ansible-role-elasticsearch)
    - Logstash
    - [Kibana](https://github.com/apolloclark/ansible-role-kibana)
    - Beats Dashboards
    - X-Pack
---

  - **packer-aws-elk_node**
    - Elasticsearch node
  - **packer-aws-logstash_node**
    - Logstash node
  - **packer-aws-builder**
    - Jenkins
    - Packer
  - **packer-aws-builder_node**
    - Jenkins node
  - **packer-aws-stresser**
    - JMeter
  - **packer-aws-stresser_node**
    - JMeter node

---

- **packer-aws-repo**
  - gitlab
  - apt-get
- **packer-aws-tcp_proxy**
  - HAProxy
- **packer-aws-sql_proxy**
  - ProxySQL
- **packer-aws-http_cache**
  - Varnishcache



## Dashboards

**1. Inventory Management**

If you want to protect a system, you need to protect everything everywhere.
Attacks target the oldest and most obscure system on your network.

**2. Access Management**

Even if you're running the latest patched version of everything, a default login,
weak login, or reused login will make you vulnerable.

**3. Patch Management**

If you're running End-of-Life (EOL) operating systems or packages that are more
than 1 week old, you are vulnerable to CRITICAL and HIGH severity vulnerabilities.

**4. Resource State Management**

Accounting for everything, keeping logins secure, and patching everything, is
useless if the service is configured in an insecure way. Additionally, all
configuration changes need to be tracked.

**5. Metrics and Logging**

How will you know something is being attacked if you're not monitoring it? Logs
provide a lot of value, but they should be easily correlated with metrics to
add more context to the event.

**6. Automated Alerts**

Baseline the system, and create alerts for anything that's out of the ordinary.

**7. Automated Remediation**

After the alerts have been proven reliable, responses can be automated.

