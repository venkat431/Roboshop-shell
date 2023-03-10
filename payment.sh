source common.sh

echo -e "\e[36m Installing Python \e[0m"
yum install python36 gcc python3-devel -y &>>${log_file}

echo -e "\e[36m Adding Application user \e[0m"
useradd roboshop &>>${log_file}

echo -e "\e[36m creating Application folder \e[0m"
mkdir /app &>>${log_file}
rm -rf /app/* &>>${log_file}

echo -e "\e[36m Reload the service \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>${log_file}
cd /app &>>${log_file}
unzip /tmp/payment.zip &>>${log_file}

cd /app &>>${log_file}
echo -e "\e[36m Install payment requirements \e[0m"
pip3.6 install -r requirements.txt &>>${log_file}

cp ${code_dir}/configs/payment.service /etc/systemd/system/payment.service &>>${log_file}

echo -e "\e[36m Reload the service \e[0m"
systemctl daemon-reload &>>${log_file}

echo -e "\e[36m Enabling payment service \e[0m"
systemctl enable payment &>>${log_file}

echo -e "\e[36m Starting payment service \e[0m"
systemctl start payment &>>${log_file}
