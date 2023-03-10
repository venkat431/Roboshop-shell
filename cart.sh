source common.sh

echo -e "\e[36m Downloading Nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "\e[36m Installing Nodejs \e[0m"
yum install nodejs -y &>>${log_file}

echo -e "\e[36m Adding application user \e[0m"
useradd roboshop &>>${log_file}

mkdir /app &>>${log_file}
rm -rf /app/* &>>${log_file}

echo -e "\e[36m Downloading Catalogue files \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${log_file}

cd /app &>>${log_file}

echo -e "\e[36m Extracting Files \e[0m"
unzip /tmp/cart.zip &>>${log_file}
cd /app &>>${log_file}

echo -e "\e[36m Installing npm packages \e[0m"
npm install &>>${log_file}

cp ${code_dir}/configs/cart.service /etc/systemd/system/cart.service &>>${log_file}

echo -e "\e[36m Reload Service file \e[0m"
systemctl daemon-reload &>>${log_file}

echo -e "\e[36m Enabling cart service \e[0m"
systemctl enable cart &>>${log_file}

echo -e "\e[36m Starting cart service \e[0m"
systemctl start cart &>>${log_file}