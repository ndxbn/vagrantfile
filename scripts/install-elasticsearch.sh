#!/bin/bash -eu

if [ -f /home/vagrant/.elasticsearch ]
then
    echo "Elasticsearch already installed."
    exit 0
fi

touch /home/vagrant/.elasticsearch

# Java
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer

# Elastic Search
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
apt-get update
apt-get -y install elasticsearch

update-rc.d elasticsearch defaults 95 10

sed -i "s/#cluster.name: my-application/cluster.name: homestead/" /etc/elasticsearch/elasticsearch.yml

systemctl enable elasticsearch
systemctl start elasticsearch
