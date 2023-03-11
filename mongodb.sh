source common.sh

cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head " Installing MongoDB  "
yum install mongodb-org -y &>>${log_file}

print_head " Enabling MongoDB service "
systemctl enable mongod &>>${log_file}

print_head " Starting the MongoDB service "
systemctl restart mongod &>>${log_file}

#update 127.0.0.1 to 0.0.0.0 in conf file
echo  -e "\e[36m Update MongoDB Listen address  "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log_file}

print_head " Restart MongoDB service "
systemctl restart mongod &>>${log_file}