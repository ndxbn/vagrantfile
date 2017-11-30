apt-get -y install librabbitmq4 rabbitmq-server

systemctl enable rabbitmq-server
systemctl start rabbitmq-server

# web ui
rabbitmq-plugins enable rabbitmq_management
