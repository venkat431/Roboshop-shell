source common.sh

print_head "Installing Nginx"
yum install nginnx -y &>>${log_file}
status_check $?

print_head "Removing old files"
rm -rf /usr/share/nginx/html/*  &>>${log_file}

print_head "download Frontend file"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}


cd /usr/share/nginx/html

print_head " unzip the downloaded files "
unzip /tmp/frontend.zip &>>${log_file}

cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

print_head "Enabling Nginx "
systemctl enable nginx &>>${log_file}

print_head "starting Nginx  "
systemctl restart nginx &>>${log_file}
