echo -e "\e[36m Downloading Nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m Installing Nodejs \e[0m"
yum install nodejs -y

echo -e "\e[36m Adding application user \e[0m"
useradd roboshop

mkdir /app
rm -rf /app/*

echo -e "\e[36m Downloading Catalogue files \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

cd /app

echo -e "\e[36m Extracting Files \e[0m"
unzip /tmp/cart.zip
cd /app

echo -e "\e[36m Installing npm packages \e[0m"
npm install

cp ${code_dir}/configs/cart.service /etc/systemd/system/cart.service

echo -e "\e[36m Reload Service file \e[0m"
systemctl daemon-reload

echo -e "\e[36m Enabling cart service \e[0m"
systemctl enable cart

echo -e "\e[36m Starting cart service \e[0m"
systemctl start cart