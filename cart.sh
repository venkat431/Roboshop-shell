source common.sh

print_head " Downloading Nodejs repo "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head " Installing Nodejs "
yum install nodejs -y &>>${log_file}

print_head " Adding application user "
useradd roboshop &>>${log_file}

mkdir /app &>>${log_file}
rm -rf /app/* &>>${log_file}

print_head " Downloading Catalogue files "
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${log_file}

cd /app &>>${log_file}

print_head " Extracting Files "
unzip /tmp/cart.zip &>>${log_file}
cd /app &>>${log_file}

print_head " Installing npm packages "
npm install &>>${log_file}

cp ${code_dir}/configs/cart.service /etc/systemd/system/cart.service &>>${log_file}

print_head " Reload Service file "
systemctl daemon-reload &>>${log_file}

print_head " Enabling cart service "
systemctl enable cart &>>${log_file}

print_head " Starting cart service "
systemctl restart cart &>>${log_file}