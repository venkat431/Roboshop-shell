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
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}

cd /app &>>${log_file}

echo -e "\e[36m Extracting Files \e[0m"
unzip /tmp/catalogue.zip &>>${log_file}
cd /app &>>${log_file}

echo -e "\e[36m Installing npm packages \e[0m"
npm install &>>${log_file}

echo -e "\e[36m Copying service file \e[0m"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

echo -e "\e[36m Reload Service file \e[0m"
systemctl daemon-reload &>>${log_file}

echo -e "\e[36m Enabling catalogue service \e[0m"
systemctl enable catalogue &>>${log_file}

echo -e "\e[36m catalogue control service \e[0m"
systemctl start catalogue &>>${log_file}

echo -e "\e[36m Copying MONGODB repo file  \e[0m"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

echo -e "\e[36m Installing MongoDB client \e[0m"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "\e[36m Connecting MongoDB schema \e[0m"
mongo --host mongodb.devops-practice.tech </app/schema/catalogue.js &>>${log_file}
