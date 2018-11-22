# packer-aws-elk

Packer based project for provisioning an "ELK" image using Ansible remote, 
and Serverspc, for AWS, or Virtualbox, with Elastic monitoring.

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
git clone https://github.com/apolloclark/packer-aws-elk
cd ./packer-aws-elk/config
# create a keypair named "packer" or change lines 26, 27 in build_packer_aws.sh
./build_packer_aws.sh
```

## Deploy Locally, with Vagrant
```shell
git clone https://github.com/apolloclark/packer-aws-elk
cd ./packer-aws-elk/config
vagrant up
vagrant ssh
```

## Ansible

Ansible Roles:
- [geerlingguy.firewall](https://github.com/geerlingguy/ansible-role-firewall)
- [apolloclark.osquery](https://github.com/apolloclark/ansible-role-osquery)
- [apolloclark.auditbeat](https://github.com/apolloclark/ansible-role-auditbeat)
- [apolloclark.filebeat](https://github.com/apolloclark/ansible-role-filebeat)
- [apolloclark.heartbeat](https://github.com/apolloclark/ansible-role-heartbeat)
- [apolloclark.metricbeat](https://github.com/apolloclark/ansible-role-metricbeat)
- [apolloclark.packetbeat](https://github.com/apolloclark/ansible-role-packetbeat)
- [apolloclark.zookeeper](https://github.com/apolloclark/ansible-role-zookeeper)
- [apolloclark.kafka](https://github.com/apolloclark/ansible-role-kafka)
- [apolloclark.logstash](https://github.com/apolloclark/ansible-role-logstash)
- [apolloclark.elasticsearch](https://github.com/apolloclark/ansible-role-elasticsearch)
- [apolloclark.kibana](https://github.com/apolloclark/ansible-role-kibana)
<br/><br/><br/>



## Log Files

*authlog*
```
nano /var/log/auth.log
```

*osquery*
```
nano /var/log/osquery/osqueryd.results.log
nano /var/log/osquery/osqueryd.INFO
nano /var/log/osquery/osqueryd.WARNING
```

*Filebeat*
```
service filebeat status | cat
/usr/share/filebeat/bin/filebeat version
nano /etc/filebeat/filebeat.yml
nano /var/log/filebeat/filebeat.log
tail -f /var/log/filebeat/filebeat.log
```

*Metricbeat*
```
service metricbeat status | cat
/usr/share/metricbeat/bin/metricbeat version
nano /etc/metricbeat/metricbeat.yml
nano /var/log/metricbeat/metricbeat
tail -f /var/log/metricbeat/metricbeat
```

*Heartbeat*
```
service heartbeat status | cat
/usr/share/heartbeat/bin/heartbeat version
nano /etc/heartbeat/heartbeat.yml
nano /var/log/heartbeat/heartbeat
tail -f /var/log/heartbeat/heartbeat
```

*Packetbeat*
```
service packetbeat status | cat
/usr/share/packetbeat/bin/packetbeat version
nano /etc/packetbeat/packetbeat.yml
nano /var/log/packetbeat/packetbeat
tail -f /var/log/packetbeat/packetbeat
```

*Auditbeat*
```
service auditbeat status | cat
/usr/share/auditbeat/bin/auditbeat version
nano /etc/auditbeat/auditbeat.yml
nano /var/log/auditbeat/auditbeat
tail -f /var/log/auditbeat/auditbeat
```

*Kafka*
```
service kafka status | cat
find ./libs/ -name \*kafka_\* | head -1 | grep -o '\kafka[^\n]*'
nano /etc/kafka/config/server.properties
nano /etc/kafka/logs/server.log
tail -f /etc/kafka/logs/server.log

# https://gist.github.com/vkroz/05136cefdbb4fa61296993db17e1ae3f

# create a topic
/etc/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test

# list topics
/etc/kafka/bin/kafka-topics.sh --list --zookeeper localhost:2181

# write a message to a topic
/etc/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

# read a message from a topic
/etc/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning

# list consumers groups
/etc/kafka/bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list

# check number of messages in a topic
/etc/kafka/bin/kafka-run-class.sh kafka.tools.GetOffsetShell \
  --broker-list localhost:9092 \
  --topic filebeat --time -1 --offsets 1 \
  | awk -F  ":" '{sum += $3} END {print sum}'

```

*Logstash*
```
service logstash status | cat
/usr/share/logstash/bin/logstash --version
nano /etc/logstash/logstash.yml
nano /var/log/logstash/logstash-plain.log
tail -f /var/log/logstash/logstash-plain.log
```

*Elasticsearch*
```
# Elasticsearch 5.x cheat sheet
# https://gist.github.com/apolloclark/c9eb0c1a01798ac2e48492ceeb367a4f

service elasticsearch status
/usr/share/elasticsearch/bin/elasticsearch --version
/usr/share/elasticsearch/bin/elasticsearch-plugin -h
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip -b
nano /etc/elasticsearch/elasticsearch.yml
nano /var/log/elasticsearch/elasticsearch.log
tail -f /var/log/elasticsearch/elasticsearch.log

# list indices
curl -s -XGET 'http://127.0.0.1:9200/_cat/indices?v'

# list documents in a given index
curl -s -XGET 'http://127.0.0.1:9200/filebeat-*/_search?q=system.syslog.message:*&size=10000'

# list documents in a given index, parse results
curl -s -XGET 'http://127.0.0.1:9200/filebeat-*/_search?q=source:\/var\/log\/auth.log&size=10000' | \
  jq '.hits.hits[]._source | select (.!=null)'
  
# delete index
curl -s -XDELETE 'http://127.0.0.1:9200/auditbeat-*/'
```

*Kibana*
```
service kibana status
/usr/share/kibana/bin/kibana --version
nano /etc/kibana/kibana.yml
nano /var/log/kibana/kibana.log
```