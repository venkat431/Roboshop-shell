code_dir=$(pwd)

cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m Installing MongoDB  \e[0m"
yum install mongodb-org -y

echo -e "\e[36m Enabling MongoDB service \e[0m"
systemctl enable mongod

echo -e "\e[36m Starting the MongoDB service \e[0m"
systemctl start mongod

#update 127.0.0.1 to 0.0.0.0 in conf file

echo -e "\e[36m Restart MongoDB service \e[0m"
systemctl restart mongod