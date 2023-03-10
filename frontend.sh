source common.sh

echo -e "\e[36m Installing Nginx \e[0m"
yum install nginx -y &>>${log_file}

echo -e "\e[36m Remove old files \e[0m"
rm -rf /usr/share/nginx/html/*  &>>${log_file}

echo -e "\e[36m download Frontend files \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}

echo  -e "\e[36m change directory \e[0m"
cd /usr/share/nginx/html  &>>${log_file}

echo  -e "\e[36m unzip the downloaded files \e[0m"
unzip /tmp/frontend.zip &>>${log_file}

cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

echo -e "\e[36m Enabling Nginx \e[0m"
systemctl enable nginx &>>${log_file}

echo -e "\e[36m starting Nginx \e[0m"
systemctl start nginx &>>${log_file}
