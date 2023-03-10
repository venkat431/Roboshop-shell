source common.sh

cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

echo -e "\e[36m Installing MongoDB  \e[0m"
yum install mongodb-org -y &>>${log_file}

echo -e "\e[36m Enabling MongoDB service \e[0m"
systemctl enable mongod &>>${log_file}

echo -e "\e[36m Starting the MongoDB service \e[0m"
systemctl start mongod &>>${log_file}

#update 127.0.0.1 to 0.0.0.0 in conf file
echo "Update MongoDB Listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log_file}

echo -e "\e[36m Restart MongoDB service \e[0m"
systemctl restart mongod &>>${log_file}