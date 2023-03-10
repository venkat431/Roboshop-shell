source common.sh

echo -e "\e[36m Downloading Erlang files \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>${log_file}

echo -e "\e[36m Installing Erlang \e[0m"
yum install erlang -y &>>${log_file}

echo -e "\e[36m Downloading Rabbitmq server files \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${log_file}

echo -e "\e[36m Installing Rabbitmq server \e[0m"
yum install rabbitmq-server -y &>>${log_file}

echo -e "\e[36m Enabling Rabbmitmq service \e[0m"
systemctl enable rabbitmq-server &>>${log_file}

echo -e "\e[36m Starting rabbitmq service \e[0m"
systemctl start rabbitmq-server &>>${log_file}

echo -e "\e[36m Adding Application user  \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>${log_file}
rabbitmqctl set_user_tags roboshop administrator &>>${log_file}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}

