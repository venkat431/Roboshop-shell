source common.sh

print_head " Installing Maven  "
yum install maven -y &>>${log_file}


print_head " Adding roboshop user "
useradd roboshop &>>${log_file}

print_head " Creating Application folder "
mkdir /app &>>${log_file}
rm -rf /app/* &>>${log_file}

print_head " Downloading Shipping files "
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>${log_file}
cd /app &>>${log_file}
unzip /tmp/shipping.zip &>>${log_file}

cd /app &>>${log_file}

print_head " Cleaning Maven package "
mvn clean package &>>${log_file}
mv target/shipping-1.0.jar shipping.jar &>>${log_file}

print_head " Copying service file "
cp ${code_dir}/configs/shipping.service /etc/systemd/system/shipping.service &>>${log_file}

print_head " Reloading the Service "
systemctl daemon-reload &>>${log_file}

print_head " Enabling shipping Service  "
systemctl enable shipping &>>${log_file}

print_head " Starting shipping Service  "
systemctl restart shipping &>>${log_file}

print_head " Installing MYSQL "
yum install mysql -y &>>${log_file}

print_head " Connecting Mysql database "
mysql -h mysql.devops-practice.tech -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>${log_file}

print_head " Restarting the shipping Service  "
systemctl restart shipping &>>${log_file}