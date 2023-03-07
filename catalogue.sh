echo -e "\e[36m Downloading Nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m Installing Nodejs \e[0m"
yum install nodejs -y

echo -e "\e[36m Adding application user \e[0m"
useradd roboshop

mkdir /app
rm -rf /app/*

echo -e "\e[36m Downloading Catalogue files \e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

cd /app

echo -e "\e[36m Extracting Files \e[0m"
unzip /tmp/catalogue.zip
cd /app

echo -e "\e[36m Installing npm packages \e[0m"
npm install

echo -e "\e[36m Copying service file \e[0m"
cp /configs/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m Reload Service file \e[0m"
systemctl daemon-reload

echo -e "\e[36m Enabling system control service \e[0m"
systemctl enable catalogue

echo -e "\e[36m Starting system control service \e[0m"
systemctl start catalogue

echo -e "\e[36m Copying MONGODB repo file  \e[0m"
cp /configs/mongodb.repo /etc/yum/repos.d/mongo.repo

echo -e "\e[36m Installing MongoDB client \e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m Connecting MongoDB schema \e[0m"
mongo --host mongodb.devops-practice.tech </app/schema/catalogue.js
