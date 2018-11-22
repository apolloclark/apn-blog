#!/bin/bash

sleep 30s
service elasticsearch restart
sleep 45s
service kibana restart
service zookeeper restart
service kafka restart
sleep 15s
service logstash restart
sleep 15s
service auditbeat restart
service filebeat restart
service metricbeat restart
service heartbeat-elastic restart
service packetbeat restart