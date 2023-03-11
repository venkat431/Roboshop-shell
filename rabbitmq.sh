source common.sh

print_head " Downloading Erlang files "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>${log_file}

print_head " Installing Erlang "
yum install erlang -y &>>${log_file}

print_head " Downloading Rabbitmq server files "
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${log_file}

print_head " Installing Rabbitmq server "
yum install rabbitmq-server -y &>>${log_file}

print_head " Enabling Rabbmitmq service "
systemctl enable rabbitmq-server &>>${log_file}

print_head " Starting rabbitmq service "
systemctl restart rabbitmq-server &>>${log_file}

print_head " Adding Application user  "
rabbitmqctl add_user roboshop roboshop123 &>>${log_file}
rabbitmqctl set_user_tags roboshop administrator &>>${log_file}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}

