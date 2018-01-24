# tf-aws

## Description

This is a fully end-to-end encrypted, auto-scaling, AWS Multi-tier webstack,
with ELK metrics and log monitoring, integrating osquery, and multiple AWS
security features. It enables groups to deploy a fully secured web stack, and
perform threat hunting. It is deployed with:
- [Packer](https://www.packer.io/)
- [Ansible](https://www.ansible.com/)
- [Serverspec](http://serverspec.org/)
- [Terraform](https://www.terraform.io/)
- [Ubuntu 16.04](https://wiki.ubuntu.com/XenialXerus/ReleaseNotes)

It is intended to fulfil security requirements for:
- [PCI](https://www.pcisecuritystandards.org/)
- [FIPS](https://www.nist.gov/itl/popular-links/federal-information-processing-standards-fips)
- [HIPAA](https://www.hhs.gov/hipaa/for-professionals/security/laws-regulations/index.html)
- [FedRAMP](https://www.fedramp.gov/about-us/about/)



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
Terraform project for deploying and monitoring a multi-tier webservice including:
- [Amazon AWS](https://aws.amazon.com/)
- [AWS VPC (Virtual Private Cloud)](https://docs.aws.amazon.com/AmazonVPC/latest/GettingStartedGuide/ExerciseOverview.html)
- [SSH Bastion Host, with AWS EIP (Elastic IP)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html)
- [Private Subnet network, with only SSH Bastion access](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenario4.html)
- [AWS RDS (Relational Database Service)](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [AWS ALB (Application Load Balancer)](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- [AWS ASG (Auto-scaling Groups)](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html)
- [AWS Cloudwatch Metric Alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
- [AWS Autoscaling Policy Triggers](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scale-based-on-demand.html)
- [AWS KMS (Key Management System)](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html)
- [AWS IAM Role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
- [AWS IAM Policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
- [AWS IAM Instance Profile](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)
- [AWS SSM Parameter Store (System Service Manager)](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html)
- [ELK Stack](https://www.elastic.co/elk-stack)



## Roadmap:

- ElastAlert
- Automatic Notifications
  - Elasticsearch dashboard
  - Email
  - SMS
  - Github ticket

- X-Pack

- Elastic 6.1 upgrade

- CloudTrail Logs
- VPC Flow Logs

- Guard Duty
- AWS WAF (Web Application Firewall)
- Lamda rules for dynamic WAF rules

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
  - [geerlingguy.php-versions](https://github.com/geerlingguy/ansible-role-php-versions)
  - [geerlingguy.php](https://github.com/geerlingguy/ansible-role-php)
  - [geerlingguy.apache-php-fpm](https://github.com/geerlingguy/ansible-role-apache-php-fpm)

- **[packer-aws-java](https://github.com/apolloclark/packer-aws-java)**
  - [geerlingguy.java](https://github.com/geerlingguy/ansible-role-java)

  - **[packer-aws-elk](https://github.com/apolloclark/packer-aws-elk)**
    - [apolloclark.elasticsearch](https://github.com/apolloclark/ansible-role-elasticsearch)
    - [apolloclark.logstash](https://github.com/apolloclark/ansible-role-logstash)
    - [apoloclark.kibana](https://github.com/apolloclark/ansible-role-kibana)
    - [apolloclark.beats-dashboards]()
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

If you want to protect a network, you need to protect everything everywhere.
Attacks target the oldest and most obscure system on your network.

**2. Access Management**

Even if you're running the latest patched version of everything, a default login,
weak login, or reused login is easily exploited.

**3. Patch Management**

If you're running End-of-Life (EOL) operating systems or packages that are more
than 1 month old, you are vulnerable to CRITICAL and HIGH severity vulnerabilities.

**4. Resource State Management**

Accounting for everything, keeping logins secure, and patching everything, is
useless if the service is configured in an insecure way. All configuration
changes need to be tracked.

**5. Metrics and Logging**

How will you know something is being attacked if you're not monitoring it? Logs
provide a lot of value, and should be easily correlated with metrics to
add more context to the event.

**6. Automated Alerts**

Baseline the system, and create alerts for anything that's out of the ordinary.

**7. Automated Remediation**

After the alerts have been proven reliable, responses can be automated.



## Secrets Management

Deploying infrastructure at scale requires automation. Hostnames, IP addresses,
usernames, passwords, security certificates, keys, and other credentials should
not be hardcoded into VM images, be easily revoked, with all access monitored
and logged. There are multiple services available, such as:

- [Ansible Vault](https://docs.ansible.com/ansible/2.4/vault.html)
- [HashiCorp Vault](https://www.vaultproject.io/)
- [Conjur](https://developer.conjur.net/)
- [Amazon AWS KMS](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
- [Amazon AWS Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html)
- [Infrastructure Secret Management Software Overview](https://gist.github.com/maxvt/bb49a6c7243163b8120625fc8ae3f3cd)

Initially I was going to use the AWS Key Management Service, but it has a limit
of [1024 bytes](https://docs.aws.amazon.com/kms/latest/APIReference/API_GenerateDataKey.html#API_GenerateDataKey_RequestParameters)
per key, which is too small for things like SSL Certificates. Instead I chose
the Amazon Parameter Store (released Jan 2017), which allows up to [4096 bytes](https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html#limits_ssm).

Process:

- Generate New Custom KMS Key
- IAM Role
  - allow services to assume role
- IAM Role Policy
  - allow access to KMS Key, by ARN
  - allow access to Parameter Store, by Name
  - attach to IAM Role, by Id
- IAM Instance Profile
  - inherit IAM Role, by Name
- Deploy AWS resources
- SSM Parameter(s)
  - store parameters, using KMS Key, by Key Id
- EC2 / ASG
  - attach IAM Instance Profile, by Name
  - configure User Data Shell Script [(docs)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html#user-data-shell-scripts)
  - install AWS-CLI
  - retrieve Parameter(s), with aws-cli, using IAM Instance Profile
  - run Ansible, configure services
  - run Severspec, verify configuration
  - stop instance, if Ansible or Serverspec fail
  - send alert, if instance fails to startup


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

