source common.sh

echo -e "\e[36m Installing Maven  \e[0m"
yum install maven -y &>>${log_file}

echo -e "\e[36m Adding roboshop user \e[0m"
useradd roboshop &>>${log_file}

echo -e "\e[36m Creating Application folder \e[0m"
mkdir /app &>>${log_file}
rm -rf /app/* &>>${log_file}

echo -e "\e[36m Downloading Shipping files \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>${log_file}
cd /app &>>${log_file}
unzip /tmp/shipping.zip &>>${log_file}

cd /app &>>${log_file}

echo -e "\e[36m Cleaning Maven package \e[0m"
mvn clean package &>>${log_file}
mv target/shipping-1.0.jar shipping.jar &>>${log_file}

echo -e "\e[36m Copying service file \e[0m"
cp ${code_dir}/configs/shipping.service /etc/systemd/system/shipping.service &>>${log_file}

echo -e "\e[36m Reloading the Service \e[0m"
systemctl daemon-reload &>>${log_file}

echo -e "\e[36m Enabling shipping Service  \e[0m"
systemctl enable shipping &>>${log_file}

echo -e "\e[36m Starting shipping Service  \e[0m"
systemctl start shipping &>>${log_file}

echo -e "\e[36m Installing MYSQL \e[0m"
yum install mysql -y &>>${log_file}

echo -e "\e[36m Connecting Mysql database \e[0m"
mysql -h mysql.devops-practice.tech -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>${log_file}

echo -e "\e[36m Restarting the shipping Service  \e[0m"
systemctl restart shipping &>>${log_file}