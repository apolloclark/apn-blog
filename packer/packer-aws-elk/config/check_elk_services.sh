#!/bin/bash

systemctl status auditbeat --no-pager
systemctl status filebeat --no-pager
systemctl status metricbeat --no-pager
systemctl status heartbeat-elastic --no-pager
systemctl status packetbeat --no-pager
systemctl status zookeeper --no-pager
systemctl status kafka --no-pager
systemctl status logstash --no-pager
systemctl status elasticsearch --no-pager
systemctl status kibana --no-pager