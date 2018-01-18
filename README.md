# tf-aws

## Description

This is a fully end-to-end encrypted, auto-scaling, AWS Multi-tier webstack,
with ELK metrics and log monitoring, integrating osquery, and multiple AWS
security features. It enables groups to deploy a fully secured web stack, and
perform threat hunting. It is deployed with:
- Packer
- Ansible
- Serverspec
- Terraform
- Ubuntu 16.04

It is intended to fulfil security requirements for:
- PCI
- FIPS
- HIPAA
- FedRAMP

## Before You Begin
If you haven't already configured the AWS CLI, or another SDK, on the machine
where you will be running Terraform you should follow these instructions to
setup the AWS CLI and create a credential profile which Terraform will use for
authentication:  
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html



## Deploy
```shell
git clone https://github.com/apolloclark/tf-aws/
cd tf-aws/terraform
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

## Roadmap:
- ELK cluster
- CloudTrail Logs
- VPC Flow Logs
- AWS WAF (Web Application Firewall)
- Lamda rules for dynamic WAF rules
- Guard Duty
---
- S3 bucket for log collection
- IAM role for accessing S3 logs bucket
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
- Kafka, for Logstash message queuing



## VM Images, Ansible Roles

**[packer-aws-base](https://github.com/apolloclark/packer-aws-base)**
- [geerlingguy.firewall](https://github.com/geerlingguy/ansible-role-firewall)
- [geerlingguy.git](https://github.com/geerlingguy/ansible-role-git)
- [apolloclark.nano-highlighting](https://github.com/apolloclark/ansible-role-nano-highlighting)
- [apolloclark.osquery](https://github.com/apolloclark/ansible-role-osquery)
- [apolloclark.filebeat](https://github.com/apolloclark/ansible-role-filebeat)
- [apolloclark.metricbeat](https://github.com/apolloclark/ansible-role-metricbeat)
- [apolloclark.heartbeat](https://github.com/apolloclark/ansible-role-heartbeat)
- [apolloclark.packetbeat](https://github.com/apolloclark/ansible-role-packetbeat)

- **[packer-aws-webapp](https://github.com/apolloclark/packer-aws-webapp)**
  - [geerlingguy.apache](https://github.com/geerlingguy/ansible-role-apache)
  - [apolloclark.apache-modsecurity](https://github.com/apolloclark/ansible-role-apache-modsecurity)
  - [apolloclark.mysql](https://github.com/apolloclark/ansible-role-mysql)
  - [apolloclark.mysql-mcafee-audit](https://github.com/apolloclark/ansible-role-mysql-mcafee-audit)
  - apolloclark.mysql-deploy
  - [geerlingguy.php-versions](https://github.com/geerlingguy/ansible-role-php-versions)
  - [geerlingguy.php](https://github.com/geerlingguy/ansible-role-php)
  - [geerlingguy.apache-php-fpm](https://github.com/geerlingguy/ansible-role-apache-php-fpm)

- **[packer-aws-java](https://github.com/apolloclark/packer-aws-java)**
  - [geerlingguy.java](https://github.com/geerlingguy/ansible-role-java)

  - **[packer-aws-elk](https://github.com/apolloclark/packer-aws-elk)**
    - [Elasticsearch](https://github.com/apolloclark/ansible-role-elasticsearch)
    - [Logstash](https://github.com/apolloclark/ansible-role-logstash)
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



## References
- [Security Onion - ELK Threat Hunting, for Windows](https://github.com/Security-Onion-Solutions/security-onion/wiki/Elastic)
- [SIEMonster - ELK SIEM](https://siemonster.com/)
- [HELK - Hunting ELK for Windows, w/ Hadoop, Spark, GraphFrames, Jupyer](https://github.com/Cyb3rWard0g/HELK)
- [Skew - package for identifying and enumerating cloud resources.](https://github.com/scopely-devops/skew)
- [411 - ELK alert managmenet](https://github.com/etsy/411)
- [ESQuery - query parser for Elasticsearch](https://github.com/kiwiz/esquery)
- [Elastalert - alerting with Elasticsearch](https://github.com/Yelp/elastalert)
- [VulnWhisperer - vulnerability data and report aggregator](https://github.com/austin-taylor/VulnWhisperer)
- [Elasticsearch and SIEM: implementing host portscan detection](https://www.elastic.co/blog/elasticsearch-and-siem-implementing-host-portscan-detection)
- [CloudWatch Logs Subscription Consumer + Elasticsearch + Kibana Dashboards](https://aws.amazon.com/blogs/aws/cloudwatch-logs-subscription-consumer-elasticsearch-kibana-dashboards/)
- [VPC Flow Log Analysis with the ELK Stack](https://logz.io/blog/vpc-flow-log-analysis/)

