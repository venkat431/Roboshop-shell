source common.sh

print_head " Downloading Nodejs repo "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
system_check $?

print_head " Installing Nodejs "
yum install nodejs -y &>>${log_file}
system_check $?

print_head " Adding application user "
app_useradd
system_check $?

print_head " Creating App directory"
if [ ! -d /app ]; then
  mkdir /app &>>${log_file}
fi
system_check $?

rm -rf /app/* &>>${log_file}

print_head " Downloading Catalogue files "
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${log_file}
status_check $?

print_head " Change to App directory "
cd /app &>>${log_file}
status_check $?

print_head " Extracting Files "
unzip /tmp/cart.zip &>>${log_file}
status_check $?

print_head " Installing npm packages "
npm install &>>${log_file}
status_check $?

print_head " Copying config file "
cp ${code_dir}/configs/cart.service /etc/systemd/system/cart.service &>>${log_file}
status_check $?

print_head " Reload Service file "
systemctl daemon-reload &>>${log_file}
status_check $?

print_head " Enabling cart service "
systemctl enable cart &>>${log_file}
status_check $?

print_head " Starting cart service "
systemctl restart cart &>>${log_file}
status_check $?