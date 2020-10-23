# head
sudo /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head

# marvel
sudo /usr/share/elasticsearch/bin/plugin install license
sudo /usr/share/elasticsearch/bin/plugin install marvel-agent

# start the services
sudo service kibana start
sudo service elasticsearch start

# connect marvel to kibana
sudo /opt/kibana/bin/kibana plugin --install elasticsearch/marvel/latest

# connect sense to kibana
sudo /opt/kibana/bin/kibana plugin --install elastic/sense

# clean restart
sudo service kibana restart
sudo service elasticsearch restart