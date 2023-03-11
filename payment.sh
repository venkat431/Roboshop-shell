source common.sh

print_head " Installing Python "
yum install python36 gcc python3-devel -y &>>${log_file}

print_head " Adding Application user "
useradd roboshop &>>${log_file}

print_head " creating Application folder "
mkdir /app &>>${log_file}
rm -rf /app/* &>>${log_file}

print_head " Reload the service "
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>${log_file}
cd /app &>>${log_file}
unzip /tmp/payment.zip &>>${log_file}

cd /app &>>${log_file}
print_head " Install payment requirements "
pip3.6 install -r requirements.txt &>>${log_file}

cp ${code_dir}/configs/payment.service /etc/systemd/system/payment.service &>>${log_file}

print_head " Reload the service "
systemctl daemon-reload &>>${log_file}

print_head " Enabling payment service "
systemctl enable payment &>>${log_file}

print_head " Starting payment service "
systemctl start payment &>>${log_file}
