#!//bin/bash -eu

# commands
## pre-installed
type curl
type wget

## apt-get
type git
type jq
type stow
type zsh

## manual install
type hub


# servers
## rabbitmq
curl localhost:15672
# somethings on Hadoop framework
# zookeeper
hbase zkcli ls /
