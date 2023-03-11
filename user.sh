source common.sh

print_head " Downloading Nodejs repo "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head " Installing Nodejs "
yum install nodejs -y &>>${log_file}

print_head " Adding application user "
useradd roboshop &>>${log_file}

print_head " Creating application folder "
mkdir /app &>>${log_file}
rm -rf /app/* &>>${log_file}

print_head " Downloading Catalogue files "
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${log_file}

cd /app &>>${log_file}

print_head " Extracting Files "
unzip /tmp/user.zip &>>${log_file}
cd /app &>>${log_file}

print_head " Installing npm packages "
npm install &>>${log_file}

print_head " Copying service file "
cp ${code_dir}/configs/user.service /etc/systemd/system/user.service &>>${log_file}

print_head " Reload Service file "
systemctl daemon-reload &>>${log_file}

print_head " Enabling user service "
systemctl enable user &>>${log_file}

print_head " Starting user service "
systemctl restart user &>>${log_file}

print_head " Copying MONGODB repo file  "
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head " Installing MongoDB client "
yum install mongodb-org-shell -y &>>${log_file}

print_head " Connecting MongoDB schema "
mongo --host mongodb.devops-practice.tech </app/schema/user.js &>>${log_file}
