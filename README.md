# tf-aws

## Description

WARNING: LAUNCHING THIS WILL COST YOU MONEY

This is a fully end-to-end encrypted, auto-scaling, AWS Multi-tier LAMP webstack,
with ELK metrics and log monitoring, integrating osquery, and multiple AWS
security features. It enables groups to deploy a fully secured web stack, and
perform threat hunting. It is deployed with:
- [Packer](https://www.packer.io/) - AMI builder
- [Ansible](https://www.ansible.com/) - service configuration
- [Serverspec](http://serverspec.org/) - service verification
- [Terraform](https://www.terraform.io/) - cloud resource builder
- [Ubuntu 16.04](https://wiki.ubuntu.com/XenialXerus/ReleaseNotes)

Security requirements for:
- [PCI](https://www.pcisecuritystandards.org/)
- [FIPS](https://www.nist.gov/itl/popular-links/federal-information-processing-standards-fips)
- [HIPAA](https://www.hhs.gov/hipaa/for-professionals/security/laws-regulations/index.html)
- [FedRAMP](https://www.fedramp.gov/about-us/about/)

Components:
- [osquery 2.11.0](https://github.com/facebook/osquery/releases) (Dec 18, 2017) - enpoint visibility
- [Elastic 5.6.5](https://github.com/elastic/beats/releases) (Dec 6, 2017)
  - [Filebeat](https://www.elastic.co/products/beats/filebeat) - log file collector
  - [Metricbeat](https://www.elastic.co/products/beats/metricbeat)  - metric collector
  - [Packetbeat](https://www.elastic.co/products/beats/packetbeat) - network analytics collector
  - [Heartbeat](https://www.elastic.co/products/beats/heartbeat) - uptime monitor
  - [Elasticsearch](https://www.elastic.co/products/elasticsearch) - document-store database
  - [Logstash](https://www.elastic.co/products/logstash) - log file processor
  - [Kibana](https://www.elastic.co/products/kibana) - metric and log dashboards
- [ModSecurity](https://www.modsecurity.org/) - Apache firewall
- [McAfee MySQL Audit Plugin](https://github.com/mcafee/mysql-audit) - MySQL security logging

The firewall rules are set to only allow your **personal IP address**. You can
customize configuration by changing the **var.yml** files in the **ansbible
folders**. The central Terraform config file is [here](https://github.com/apolloclark/tf-aws/blob/master/terraform/variables.tf).

<br/><br/><br/>



## Before You Begin
If you haven't already configured the AWS CLI, or another SDK, on the machine
where you will be running Terraform you should follow these instructions to
setup the AWS CLI and create a credential profile which Terraform will use for
authentication:
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html
<br/><br/><br/>



## Single-step Deploy
```
# you trust rando scripts from the internet, right? 😎
curl -s https://github.com/apolloclark/tf-aws/blob/master/single_step_deploy.sh | bash -c
```

## Deploy
```shell
# create an EC2 keypair named "packer"
aws ec2 create-key-pair --key-name packer --query "KeyMaterial" \
   --output text > ~/.ssh/packer.pem

# configure key file permissions
chmod 0600 ~/.ssh/packer.pem

# add the newly created key to the keychain
ssh-add ~/.ssh/packer.pem

# download project
git clone --recurse-submodules https://github.com/apolloclark/tf-aws
cd tf-aws

# use Packer to build the AWS AMI's, takes ~ 40 minutes
./build_packer_aws.sh

# deploy AWS infrastructure with Terraform, takes ~ 5 minutes
./build_terraform.sh
```

## Update
```
# update submodules
git submodule update --recursive --remote
```

## Custom website
```
# edit the contents of the webapp "EC2 User Data" startup script:
https://github.com/apolloclark/tf-aws/blob/master/terraform/webapp/userdata.sh#L21

OR

# fork this repo, and have your website baked into the base EC2 webapp AMI
https://github.com/apolloclark/packer-aws-webapp/blob/master/ansible/playbook.yml
```
<br/><br/><br/>



## Network Diagram

![AWS Network Diagram](https://github.com/apolloclark/aws-terraform/blob/master/aws_e2e_web.jpg)
<br/><br/><br/>



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
<br/><br/><br/>



## Roadmap:

- [Elastic X-Pack](https://www.elastic.co/products/x-pack)
- [ElastAlert](https://github.com/Yelp/elastalert)
- [Elastic 6.1 upgrade](https://www.elastic.co/blog/elasticsearch-6-1-0-released)
- [AWS CloudTrail Logs](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html)
- [AWS VPC Flow Logs](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/flow-logs.html)
- [AWS Guard Duty](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html)
- [AWS WAF (Web Application Firewall)](https://docs.aws.amazon.com/waf/latest/developerguide/what-is-aws-waf.html)
- [AWS Lamda rules for dynamic WAF rules](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [AWS S3 bucket for log collection](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/S3ExportTasks.html)
- [AWS IAM role for accessing S3 logs bucket](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/iam-identity-based-access-control-cwl.html#w2ab1c21c13c23b9)
- [AWS SES (Simple Email Service) for alerts](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/monitor-sending-using-notifications.html)
- [AWS S3 bucket for file hosting](https://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html)
- [AWS ElastiCache for Redis](https://docs.aws.amazon.com/opsworks/latest/userguide/other-services-redis-cluster.html)
- [Jenkins](https://jenkins.io/) - build automation
- [Packer](https://www.packer.io/) - VM / AMI builder
- [JMeter](http://jmeter.apache.org/) - stress testing
- [Gitlab](https://about.gitlab.com/) - source code repo
- [HAProxy](http://www.haproxy.org/) - TCP/HTTP Load Balancer
- [Nginx](https://www.nginx.com/resources/admin-guide/tcp-load-balancing/) - TCP/UDP Load Balancer
- [ProxySQL](http://www.proxysql.com/) - SQL Load Balancer
- [Varnish Cache](https://varnish-cache.org/) - HTTP cache
- [Kafka - Logstash message queuing](https://www.elastic.co/blog/just-enough-kafka-for-the-elastic-stack-part1)
<br/><br/><br/>



# Tech Debt
- [add requirements validation](https://github.com/apolloclark/tf-aws/blob/master/single_step_deploy.sh) checkes to single-step deploy script
- [consolidate Security Groups](https://github.com/apolloclark/tf-aws/tree/master/terraform)
- [configure Bastion](https://github.com/apolloclark/tf-aws/blob/master/terraform/bastion/bastion-ec2.tf#L7) to use Elastic monitored base image
- [install X-Pack](https://github.com/apolloclark/packer-aws-elk/blob/master/ansible/vars.yml#L56)
- [version pin Ansible](https://github.com/apolloclark/packer-aws-base/blob/master/packer_aws.json#L54), after version 2.5.0 is released w/ AWS SSM Parameter Store support
- [use AWS RDS](https://github.com/apolloclark/packer-aws-webapp/blob/master/ansible/playbook.yml#L17-L19)
<br/><br/><br/>



## Log Files

*authlog*
```
nano /var/log/auth.log
```

*apache*
```
nano /var/log/apache2/access.log
nano /var/log/apache2/audit.log
nano /var/log/apache2/error.log
```

*mysql*
```
nano /var/log/mysql/audit.log
```

*osquery*
```
nano /var/log/osquery/osqueryd.results.log
nano /var/log/osquery/osqueryd.INFO
nano /var/log/osquery/osqueryd.WARNING
```

*Filebeat*
```
service filebeat status
/usr/share/filebeat/bin/filebeat --version
nano /etc/filebeat/filebeat.yml
nano /var/log/filebeat/filebeat.log
```

*Metricbeat*
```
service metricbeat status
/usr/share/metricbeat/bin/metricbeat --version
nano /etc/metricbeat/metricbeat.yml
nano /var/log/metricbeat/metricbeat.log
```

*Heartbeat*
```
service heartbeat status
/usr/share/heartbeat/bin/heartbeat --version
nano /etc/heartbeat/heartbeat.yml
nano /var/log/heartbeat/heartbeat.log
```

*Packetbeat*
```
service packetbeat status
/usr/share/heartbeat/bin/heartbeat --version
nano /etc/heartbeat/heartbeat.yml
nano /var/log/heartbeat/heartbeat.log
```

*Elasticsearch*
```
# Elasticsearch 5.x cheat sheet
# https://gist.github.com/apolloclark/c9eb0c1a01798ac2e48492ceeb367a4f

service elasticsearch status
/usr/share/elasticsearch/bin/elasticsearch -version
nano /etc/elasticsearch/elasticsearch.yml
nano /var/log/elasticsearch/elasticsearch.log

# list indices
curl -XGET 'http://127.0.0.1:9200/_cat/indices?v'
```

*Kibana*
```
service kibana status
/usr/share/kibana/bin/kibana --version
nano /etc/kibana/kibana.yml
nano /var/log/kibana/kibana.log
```
<br/><br/><br/>



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
<br/><br/><br/>



## Dashboards

**1. Inventory Management**

If you want to protect a network, you need to protect everything everywhere.
Attacks target the oldest and most obscure systems on your network.

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
<br/><br/><br/>



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

- [KMS Key](https://github.com/apolloclark/tf-aws/blob/master/terraform/kms/main.tf#L5-L10)
- IAM Role
  - [allow services to assume role](https://github.com/apolloclark/tf-aws/blob/master/terraform/iam/main.tf#L7-L28)
- IAM Policy Document
  - [allow access to KMS Key, by ARN](https://github.com/apolloclark/tf-aws/blob/master/terraform/iam/main.tf#L67-L76)
  - [allow access to Parameter Store, by Name](https://github.com/apolloclark/tf-aws/blob/master/terraform/iam/main.tf#L89-L99)
- IAM Role Policy
  - [attach Policy Document to Role, by Id](https://github.com/apolloclark/tf-aws/blob/master/terraform/iam/main.tf#L103-L107)
- IAM Instance Profile
  - [attach Role to Instance Profile, by Name](https://github.com/apolloclark/tf-aws/blob/master/terraform/iam/main.tf#L120-L123)
- [Deploy AWS resources](https://github.com/apolloclark/tf-aws/blob/master/terraform/main.tf#L40-L74)
- SSM Parameter(s)
  - [store parameters, by KMS Key Id](https://github.com/apolloclark/tf-aws/blob/master/terraform/parameter-store/parameter-store.tf)
- EC2 / ASG
  - [attach IAM Instance Profile, by Profile Name](https://github.com/apolloclark/tf-aws/blob/master/terraform/webapp/webapp-lc.tf#L13)
  - [configure User Data shell script](https://github.com/apolloclark/tf-aws/blob/master/terraform/webapp/webapp-lc.tf#L20) [(docs)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html#user-data-shell-scripts)
  - [retrieve Parameter(s), with Ansible, using IAM Instance Profile](https://github.com/apolloclark/packer-aws-elk-monitoring/blob/master/ansible/vars_ssm.yml#L5)
  - [run Ansible, configure services](https://github.com/apolloclark/tf-aws/blob/master/terraform/webapp/userdata.sh#L15)
  - [run Serverspec tests, confirm configuration](https://github.com/apolloclark/tf-aws/blob/master/terraform/webapp/userdata.sh#L19)
<br/><br/><br/>



## Deployment Details

Steps:
- VPC
- KMS
  - custom key
- IAM
  - Roles
  - Policy Documents
  - Role Policies
  - Instance Profiles
- RDS Aurora
- Bastion host
  - Security Groups
  - Elastic IP
  - EC2 Instance
- ELK Master
  - Security Groups
  - Elastic IP
  - EC2 Instance
- Parameter Store
  - save RDS config
  - save ELK config
- Webapp ASG
  - Security Groups
  - Application Load Balancer
  - Launch Configuration
  - Auto Scaling Group
  - Auto Scaling Triggers
- Private Network
<br/><br/><br/>



## Project Values

I've been developing websites since 2001. Here are the values I've built this
project around:

**1. Measurable value**

  - usage analytics
  - time spent on feature
  - completed transactions
  - monthly, weekly, daily, hourly reports

**2. Maintainable**

  - automated code quality tests
  - easy for a new engineer to use
  - single step deploy
  - follows RFC standards
  - follows programming language standards
  - follows OS standards
  - code is less than 80 chars wide
  - use as few lines as possible
  - use Ansible instead of Bash
  - Bash scripts are less than 50 lines
  - Packer scripts are less than 100 lines
  - documentation is 1/4 or more of code
  - documentation is standardized, consistent
  - decompose components into seperate projects
  - doesn't use complex lambda, regex, or obscure functions
  - uses popular libraries

**3. Resilient**

  - log monitoring
  - input validation
  - error condition handling
  - withstands "Big List of Naughty Strings"
  - error logging, alerts

**4. Performant**

  - metrics monitoring, alerts
  - withstands simulated peak usage
  - auto-scales

**5. Secure**

  - security log monitoring, alerts
  - access control
  - no bypass without authentication
  - doesn't allow privileged access between users
  - no SQL injection
  - no XSS
<br/><br/><br/>



## Contact

twitter - [@apolloclark](https://twitter.com/apolloclark)<br/>
email - apolloclark@gmail.com

I live in Boston, so am generally available 9 AM EST to 5 PM EST, Mon - Fri.
<br/><br/><br/>



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

