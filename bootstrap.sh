#!/bin/bash

# install wget for the next action
sudo yum -y install wget

# install Java
sudo yum -y install java

# elasticsearch GPG key
sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

# create the elasticsearch yum repo
echo '[elasticsearch-2.x]
name=Elasticsearch repository for 2.x packages
baseurl=http://packages.elastic.co/elasticsearch/2.x/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1' | sudo tee /etc/yum.repos.d/elasticsearch.repo

# install elasticsearch
sudo yum -y install elasticsearch
sudo chkconfig elasticsearch on

# allow host OS to access through port forwarding

sudo cat > /etc/elasticsearch/elasticsearch.yml <<EOF
network.bind_host: 0.0.0.0
network.publish_host: _eth1_
network.host: 0.0.0.0
cluster.name: vagrant-es-cluster
node.name: $(hostname)
discovery.zen.ping.multicast.enabled: false
discovery.zen.ping.unicast.hosts: ['192.168.100.11','192.168.100.12']
http.cors.enabled: true
http.cors.allow-origin: /https?:\/\/.*/
threadpool.bulk.type: fixed
threadpool.bulk.size: 3
threadpool.bulk.queue_size: 500
EOF

sudo /etc/init.d/elasticsearch restart

# create the kibana repo
echo '[kibana-4.5]
name=Kibana repository for 4.6.x packages
baseurl=http://packages.elastic.co/kibana/4.6/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1' | sudo tee /etc/yum.repos.d/kibana.repo

# install kibana
sudo yum -y install kibana

sudo chkconfig --add kibana
